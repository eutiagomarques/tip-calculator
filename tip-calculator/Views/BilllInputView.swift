//
//  BilllInputView.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 09/07/24.
//

import UIKit
import Combine
import CombineCocoa

class BilllInputView: UIView {
    
    private let billSubject = PassthroughSubject<Double, Never>()
    var valuePublisher: AnyPublisher<Double, Never> {
        return billSubject.eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.setViewText(topLabel: "Valor", bottomLabel: "Total")
        return view
    }()
    
    private let textFieldContainerView: UIView =  {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 8.0)
        return view
    }()
    
    private let currencyDenominationLabel: UILabel = {
        let label = LabelFactory.build(text: "$", font: ThemeFont.bold(ofSize: 24))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }()
    
    private lazy var textField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .none
        textField.keyboardType = .decimalPad
        textField.font = ThemeFont.demiBold(ofSize: 28)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.tintColor = ThemeColor.textColor
        textField.textColor = ThemeColor.textColor
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Finalizar",
            style: .plain,
            target: self,
            action: #selector(finishButtonTapped)
        )
        toolbar.items = [doneButton]
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeHierarchy()
        makeConstraints()
        makeBinds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeBinds() {
        textField.textPublisher.sink { [unowned self] text in
            billSubject.send(text?.toDouble() ?? 0.0)
        }.store(in: &cancellables)
    }
    
    private func makeHierarchy() {
        [headerView, textFieldContainerView].forEach(addSubview(_:))
        textFieldContainerView.addSubview(currencyDenominationLabel)
        textFieldContainerView.addSubview(textField)
    }
    
    private func makeConstraints() {
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(textFieldContainerView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
        }

        textFieldContainerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        currencyDenominationLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(currencyDenominationLabel.snp.trailing).offset(16)
            make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
        }
    }
    
    
    @objc private func finishButtonTapped() {
        textField.endEditing(true)
    }
}
