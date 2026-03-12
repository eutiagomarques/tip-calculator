//
//  MainViewController.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 09/07/24.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel
    
    private let logoView = LogoView()
    private let resultView = ResultVIew()
    private let billInputView = BilllInputView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()
    
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()

    private lazy var logoViewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.numberOfTapsRequired = 2
        logoView.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    private lazy var mainStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billInputView,
            tipInputView,
            splitInputView
       ])
        
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeHierarchy()
        makeConstraints()
        makeBinds()
        makeObserve()
    }
    
    private func makeBinds() {
        
        let inputPublisher = MainViewModel.inputPublisher(
            billPublisher: billInputView.valuePublisher,
            tipPublisher: tipInputView.valuePublisher,
            splitPublisher: splitInputView.valuePublisher,
            logoTapPublisher: logoViewTapPublisher
        )
        
        let outputPublisher = viewModel.handler(input: inputPublisher)
        
        outputPublisher.updateViewPublisher
            .sink { result in
                self.resultView.handler(result: result)
            }
            .store(in: &cancellables)
        
        outputPublisher.resultCalculatorPublisher.sink { [unowned self] _ in
            billInputView.reset()
            tipInputView.reset()
            splitInputView.reset()
            
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut) {
                self.logoView.transform = .init(scaleX: 1.5, y: 1.5)
            } completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.logoView.transform = .identity
                }
            }
        }.store(in: &cancellables)
    }
    
    private func makeObserve() {
        viewTapPublisher.sink { [unowned self] _ in
            view.endEditing(true)
        }.store(in: &cancellables)
    }
    
    private func makeLayout() {
        view.backgroundColor = ThemeColor.backgroundColor
    }
    
    private func makeHierarchy() {
        view.addSubview(mainStackView)
    }
    
    private func makeConstraints() {
        
        mainStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp_leadingMargin).offset(16)
            make.trailing.equalTo(view.snp_trailingMargin).offset(-16)
            make.bottom.equalTo(view.snp_bottomMargin).offset(-16)
            make.top.equalTo(view.snp_topMargin).offset(16)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        resultView.snp.makeConstraints { make in
            make.height.equalTo(224)
        }
        
        billInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        tipInputView.snp.makeConstraints { make in
            make.height.equalTo(127)
        }
        
        splitInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
}
