//
//  AmountView.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 12/07/24.
//

import UIKit

class AmountView: UIView {
    
    private var title: String
    private var textAlignment: NSTextAlignment
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(text: title,
                           font: ThemeFont.regular(ofSize: 18),
                           textAlignment: textAlignment)
    }()
    
    private lazy var amountLabel: UILabel = {
       let label = UILabel()
        label.textColor = ThemeColor.primaryColor
        label.textAlignment = textAlignment
        let text = NSMutableAttributedString(
            string: "R$0,00",
            attributes: [
                .font: ThemeFont.bold(ofSize: 24)
            ])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 15)
        ], range: NSMakeRange(0, 2))
        label.attributedText = text
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
        titleLabel,
        amountLabel
       ])
        stackView.axis = .vertical
        return stackView
    }()
    
    init(title: String, textAlignment: NSTextAlignment) {
        self.title = title
        self.textAlignment = textAlignment
        super.init(frame: .zero)
        makeLayout()
        makeHierarchy()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
    }
    
    private func makeHierarchy() {
        addSubview(vStackView)
    }
    
    private func makeConstraints() {
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
}
