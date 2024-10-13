//
//  UIResponder+Extension.swift
//  tip-calculator
//
//  Created by Tiago de Souza Marques on 13/10/24.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController {
        return next as? UIViewController ?? next!.parentViewController
    }
}
