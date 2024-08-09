//
//  CategoryCollectionViewCell.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 26.07.24.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.borderColor = UIColor(red: 0.92, green: 0.90, blue: 0.91, alpha: 1.00).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        clipsToBounds = true
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(4)
            make.right.bottom.equalToSuperview().offset(-4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ category: Category) {
        titleLabel.text = category.name
    }
    
}
