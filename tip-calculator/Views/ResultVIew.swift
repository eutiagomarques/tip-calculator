//
//  ResultVIew.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 09/07/24.
//

import UIKit

class ResultVIew: UIView {
    
    private let headerLabel: UILabel = {
        LabelFactory.build(text: "Total p/ pessoa", font: ThemeFont.demiBold(ofSize: 18))
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(
            string: "$0,00",
            attributes: [.font: ThemeFont.bold(ofSize: 48)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(0, 1))
        label.attributedText = text
        label.textColor = ThemeColor.textColor
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separatorColor
       return view
    }()
    
    private lazy var vStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
        headerLabel,
        amountPerPersonLabel,
        separatorView,
        hStackView
       ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var hStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
        AmountView(),
        UIView(),
        AmountView()
       ])
        stackView.axis = .horizontal
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
    
    private func makeLayout() {
        backgroundColor = ThemeColor.backgroundColor
        addShadow(offSet: CGSize(width: 0, height: 3),
                  color: .black,
                  radius: 12.0,
                  opacity: 0.2)
    }
    
    private func makeHierarchy() {
        addSubview(vStackView)
    }
    
    private func makeConstraints() {
        vStackView.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
            make.top.equalTo(snp.top).offset(24)
        }
        
        separatorView.snp.makeConstraints{ make in
            make.height.equalTo(2)
        }
    }
}
