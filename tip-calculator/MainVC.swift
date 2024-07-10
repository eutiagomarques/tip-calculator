//
//  MainViewController.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 09/07/24.
//

import UIKit
import SnapKit

class MainVC: UIViewController {
    
    private let logoView = LogoView()
    private let resultView = ResultVIew()
    private let billInputView = BilllInputView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeHierarchy()
        makeConstraints()
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
