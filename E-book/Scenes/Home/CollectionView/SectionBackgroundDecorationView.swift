//
//  SectionBackgroundDecorationView.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 09.08.24.
//

import UIKit
import SnapKit

class SectionBackgroundDecorationView: UICollectionReusableView {
    static let identifier = "SectionBackgroundDecorationView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.layer.borderColor = UIColor(red: 0.92, green: 0.90, blue: 0.91, alpha: 1.00).cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
