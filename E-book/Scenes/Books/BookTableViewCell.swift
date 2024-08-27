//
//  BookTableViewCell.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 15.08.24.
//

import UIKit
import SnapKit

class BookTableViewCell: UITableViewCell {
    
    static let identifier = "BookTableViewCell"
    var onAction: (() -> Void)? = nil
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 4
        label.textColor = .black
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
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
    
    private let bookImageView = UIImageView(image: UIImage(named: "no-image"))
    
    private let moreBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("t", for: .normal)
        btn.setImage(UIImage(named: "more"), for: .normal)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        bookImageView.contentMode = .scaleAspectFill
        bookImageView.clipsToBounds = true
        bookImageView.layer.cornerRadius = 10
        addSubview(bookImageView)
        addSubview(ratingLabel)
        addSubview(titleLabel)
        addSubview(authorLabel)
        contentView.addSubview(moreBtn)
        moreBtn.addTarget(self, action: #selector(moreBtnTapped), for: .touchUpInside)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        bookImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.width.equalTo(100)
            make.height.equalTo(144)
        }
        
        moreBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(bookImageView.snp.right).offset(16)
            make.right.equalTo(moreBtn.snp.left).offset(-16)
            make.top.equalToSuperview().offset(16)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.left.equalTo(bookImageView.snp.right).offset(16)
            make.right.equalTo(moreBtn.snp.left).offset(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.left.equalTo(bookImageView.snp.right).offset(16)
            make.right.equalTo(moreBtn.snp.left).offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
    }
    
    @objc private func moreBtnTapped() {
        onAction?()
    }
    
    func configure(with book: BookShortInfo) {
        titleLabel.text = book.name
        ratingLabel.text = "рейтинг: \(book.rating)/5"
        authorLabel.text = (book.author)
    }

}
