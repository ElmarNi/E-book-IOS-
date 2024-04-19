//
//  UIView+Border.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 19.04.24.
//

import Foundation
import UIKit

extension UIView {
    func border(color: UIColor, width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
