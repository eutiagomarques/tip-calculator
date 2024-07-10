//
//  LabelFactory.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 10/07/24.
//

import UIKit

struct LabelFactory {
    static func build(text: String?,
                      font: UIFont,
                      backgroundColor: UIColor = .clear,
                      textColor: UIColor = ThemeColor.textColor,
                      textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.textAlignment = textAlignment        
        return label
    }
}
