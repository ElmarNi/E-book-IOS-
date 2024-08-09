//
//  HeaderView.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 09.08.24.
//

import UIKit
import SnapKit

class HeaderView: UICollectionReusableView {
    
    static let identifier = "HeaderView"
    
    var onAction: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()
    
    private let showAllBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Все", for: .normal)
        button.setTitleColor(UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(countLabel)
        addSubview(showAllBtn)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(24)
        }
        
        countLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        showAllBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(24)
        }
        
        showAllBtn.addTarget(self, action: #selector(showAllBtnTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func showAllBtnTapped() {
        (onAction ?? {})()
    }
    
    func configure(title: String, count: String) {
        titleLabel.text = title
        countLabel.text = "\(count) книг"
    }
}
