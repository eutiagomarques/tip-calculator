//
//  SplitInputView.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 09/07/24.
//

import UIKit

class SplitInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.setViewText(topLabel: "Qtd.", bottomLabel: "pessoas")
        return view
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(text: "-",
                                 corner: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        button.tintColor = .white
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButton(text: "+",
                                 corner: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        button.tintColor = .white
        return button
    }()
    
    private lazy var splitNumberLabel: UILabel = {
        let label = LabelFactory.build(
            text: "1",
            font: ThemeFont.bold(ofSize: 20)        )
        return label
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            decrementButton,
            splitNumberLabel,
            incrementButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 0
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
        
    }
    
    private func makeHierarchy() {
        [headerView, hStackView].forEach(addSubview(_:))
    }
    
    private func makeConstraints() {
        hStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        [incrementButton, decrementButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(button.snp.height)
            }
        }

        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(hStackView.snp.centerY)
            make.trailing.equalTo(hStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }

    }
    
    private func buildButton(text: String, corner: CACornerMask) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primaryColor
        button.addRoundCorners(corners: corner, radius: 8.0)
        return button
    }
}
