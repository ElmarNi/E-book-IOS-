//
//  UIActivityIndicatorView+Spinner.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 18.07.24.
//

import Foundation
import UIKit

class Spinner: UIActivityIndicatorView {
    init() {
        super.init(frame: .zero)
        self.hidesWhenStopped = true
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
