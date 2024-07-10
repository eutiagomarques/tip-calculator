//
//  ThemeFont.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 10/07/24.
//

import UIKit

struct ThemeFont {
    static func regular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir Next Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func demiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir Next Demi Bold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
    }
    
    static func bold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir Next Bold", size: size) ?? .boldSystemFont(ofSize: size)
    }
}
