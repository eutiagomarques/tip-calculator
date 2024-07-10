//
//  LogoView.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 09/07/24.
//

import UIKit

class LogoView: UIView {
    
    private let logoView: UIImageView = {
        let image = UIImageView(image: .init(named: "icCalculatorBW"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Sr. GORJETA",
            attributes: [.font: ThemeFont.demiBold(ofSize: 16)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(3, 8))
        label.attributedText = text
        label.textColor = ThemeColor.textColor
        return label
    }()
    
    private let bottomLabel: UILabel = {
       return LabelFactory.build(text: "Calculadora", font: ThemeFont.demiBold(ofSize: 20), textAlignment: .left)
    }()
    
    private lazy var hStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
        logoView,
        vStackView
       ])
        
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
            topLabel,
            bottomLabel
       ])
        
        stackView.axis = .vertical
        stackView.spacing = -4
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
        addSubview(hStackView)
    }
    
    private func makeConstraints() {
        hStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()

        }
        
        logoView.snp.makeConstraints{ make in
            make.height.equalTo(logoView.snp.width)
        }
    }
}
