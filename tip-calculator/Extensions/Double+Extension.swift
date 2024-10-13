//
//  Double+Extension.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 13/10/24.
//

import Foundation

extension Double {
    var currencyFormat: String {
        var isWholeNumber: Bool {
            isZero ? true: !isNormal ? false: self == rounded()
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
