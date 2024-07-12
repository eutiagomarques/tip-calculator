//
//  AmountView.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 12/07/24.
//

import UIKit

class AmountView: UIView {
    
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
        self.backgroundColor = .red
    }
    
    private func makeHierarchy() {
    }
    
    private func makeConstraints() {

    }
}
