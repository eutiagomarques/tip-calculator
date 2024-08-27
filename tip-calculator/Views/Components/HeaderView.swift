//
//  HeaderView.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 27/08/24.
//

import Foundation

import UIKit

class HeaderView: UIView {
    
    private let topLabel: UILabel = {
        LabelFactory.build(text: nil, font: ThemeFont.bold(ofSize: 18))
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(text: nil, font: ThemeFont.regular(ofSize: 18))
    }()
    
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
        topSpacerView,
        topLabel,
        bottomLabel,
        bottomSpacerView
       ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = -4
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeHierarchy()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeHierarchy() {
        addSubview(stackView)
    }
    
    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topSpacerView.snp.makeConstraints { make in
            make.height.equalTo(bottomSpacerView.snp.height)
        }
    }
    
    func setViewText(topLabel: String, bottomLabel: String) {
        self.topLabel.text = topLabel
        self.bottomLabel.text = bottomLabel
    }
}
