//
//  UIButton+Bordered.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 12.07.24.
//

import Foundation
import UIKit

class BorderedButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.borderColor = UIColor(red: 0.92, green: 0.90, blue: 0.91, alpha: 1.00).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.setTitleColor(UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00), for: .normal)
        self.backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
