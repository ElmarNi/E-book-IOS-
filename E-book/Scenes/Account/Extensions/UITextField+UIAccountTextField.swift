//
//  UITextField+UIAccountTextField.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 16.07.24.
//

import Foundation
import UIKit

class UIAccountTextField: UITextField {
    let padding = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    init(placeholder: String, 
         keyboardType: UIKeyboardType = .default,
         isSecureTextEntry: Bool = false,
         autocapitalizationType: UITextAutocapitalizationType = .none) 
    {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.keyboardType = keyboardType
        self.layer.borderColor = UIColor(red: 0.92, green: 0.90, blue: 0.91, alpha: 1.00).cgColor
        self.layer.borderWidth = 1
        self.font = .systemFont(ofSize: UIFont.systemFontSize)
        self.isSecureTextEntry = isSecureTextEntry
        self.autocapitalizationType = autocapitalizationType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
