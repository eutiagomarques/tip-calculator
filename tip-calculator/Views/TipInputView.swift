//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 09/07/24.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.setViewText(topLabel: "Taxa", bottomLabel: "Serviço")
        return view
    }()
    
    private lazy var tenPercentButton: UIButton =  {
        let button = buildTipButton(tip: .tenPercent)
        button.tapPublisher
            .map { _ in Tip.tenPercent }
            .assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var fifteenPercentButton: UIButton =  {
        let button = buildTipButton(tip: .fifteenPercent)
        button.tapPublisher
            .map { _ in Tip.fifteenPercent }
            .assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var twentyPercentButton: UIButton =  {
        let button = buildTipButton(tip: .twentyPercent)
        button.tapPublisher
            .map { _ in Tip.twentyPercent }
            .assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var customPercentButton: UIButton =  {
       let button = UIButton()
        button.setTitle("Outro Valor", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primaryColor
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        button.tapPublisher
            .sink { [weak self] _ in
                self?.handleCustomPercentButton()
            }
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var buttonHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tenPercentButton,
            fifteenPercentButton,
            twentyPercentButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var buttonVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            buttonHStackView,
            customPercentButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeLayout()
        makeHierarchy()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func handleCustomPercentButton() {
        let alertController: UIAlertController = {
            let controller = UIAlertController(
                title: "Insira o valor da taxa de serviço",
                message: nil,
                preferredStyle: .alert)
            controller.addTextField { textField in
                textField.keyboardType = .numberPad
                textField.placeholder = "Insira o valor"
                textField.autocorrectionType = .no
            }
            let cancelAction = UIAlertAction(
                title: "Cancelar",
                style: .cancel)
            let confirmAction = UIAlertAction(
                title: "OK",
                style: .default) { [weak self] _ in
                guard let self = self,
                      let text = controller.textFields?.first?.text,
                      let value = Int(text) else { return }
                self.tipSubject.send(.custom(value: value))
            }
            
            [cancelAction, confirmAction].forEach(controller.addAction(_:))
            return controller
        }()
        parentViewController.present(alertController, animated: true)
    }
    
    private func makeLayout() {
        tipSubject.sink { [unowned self] tip in
            self.updateView(tip: tip)
        }.store(in: &cancellables)
    }
    
    private func makeHierarchy() {
        [headerView, buttonVStackView].forEach(addSubview(_:))
    }
    
    private func makeConstraints() {
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(buttonHStackView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(buttonVStackView.snp.leading).offset(-24)
        }
        
        buttonVStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
    }
    
    private func buildTipButton(tip: Tip) -> UIButton{
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primaryColor
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [
                .font: ThemeFont.bold(ofSize: 20),
                .foregroundColor: UIColor.white
            ])
        text.addAttributes([
            .font: ThemeFont.demiBold(ofSize: 14)
        ], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
    
    private func resetViews() {
        [tenPercentButton, fifteenPercentButton, twentyPercentButton, customPercentButton].forEach {
            $0.backgroundColor = ThemeColor.primaryColor
        }
        
        let text = NSMutableAttributedString(
            string: "Outro Valor",
            attributes: [
                .font: ThemeFont.bold(ofSize: 20)
            ])
        customPercentButton.setAttributedTitle(text, for: .normal)
    }
    
    private func updateView(tip: Tip) {
        resetViews()
        switch tip {
        case .tenPercent:
            tenPercentButton.backgroundColor = ThemeColor.secondaryColor
        case .fifteenPercent:
            fifteenPercentButton.backgroundColor = ThemeColor.secondaryColor
        case .twentyPercent:
            twentyPercentButton.backgroundColor = ThemeColor.secondaryColor
        case .custom(let value):
            customPercentButton.backgroundColor = ThemeColor.secondaryColor
            let text = NSMutableAttributedString(
                string: "\(value)%",
                attributes: [
                    .font: ThemeFont.bold(ofSize: 20)
                ])
            customPercentButton.setAttributedTitle(text, for: .normal)
        case .none:
            break
        }
    }
}
