//
//  UIView+Extension.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 12/07/24.
//

import UIKit

extension UIView {
    func addShadow(offSet: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offSet
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let bgColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = bgColor
    }
    
    func addCornerRadius(radius: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
    
    func addRoundCorners(corners: CACornerMask, radius: CGFloat) {
        layer.maskedCorners = [corners]
        layer.cornerRadius = radius
    }
}
