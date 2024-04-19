//
//  UIView+Round.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 19.04.24.
//

import Foundation
import UIKit

extension UIView {
    func round(_ radius: CGFloat = 12) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
