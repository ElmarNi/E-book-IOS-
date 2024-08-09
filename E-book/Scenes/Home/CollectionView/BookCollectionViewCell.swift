//
//  BookCollectionViewCell.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 26.07.24.
//

import UIKit
import SnapKit

class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = UIColor(red: 0.32, green: 0.30, blue: 0.30, alpha: 1.00)
        return label
    }()
    
    private let imageView = UIImageView(image: UIImage(named: "no-image"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        addSubview(imageView)
        addSubview(ratingLabel)
        addSubview(titleLabel)
        addSubview(authorLabel)
        
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        imageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(144)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(ratingLabel.snp.bottom)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func configure(_ book: BookShortInfo) {
        titleLabel.text = book.name
        ratingLabel.text = "рейтинг: \(book.rating)/5"
        authorLabel.text = (book.author)
    }
    
}
