//
//  UIButton+Filled.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 12.07.24.
//

import Foundation
import UIKit

class FilledButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.backgroundColor = UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
