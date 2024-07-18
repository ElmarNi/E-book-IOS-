//
//  UILabel+AccountLabel.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 16.07.24.
//

import Foundation
import UIKit

class UIAccountLabel: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        self.font = .systemFont(ofSize: UIFont.systemFontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
