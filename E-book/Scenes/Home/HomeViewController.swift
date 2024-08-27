//
//  HomeViewController.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 18.07.24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    internal let viewModel = HomeViewModel()
    
    private let spinner = Spinner()
    
    private lazy var collectionView: UICollectionView = {
        let layout = HomeViewController.createCompositionalLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        cv.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        cv.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.isHidden = true
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        fetchData()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 0.99, green: 0.96, blue: 0.95, alpha: 1.00)
        collectionView.backgroundColor = view.backgroundColor
        
        title = "Книги для тебя"
        view.addSubview(collectionView)
        view.addSubview(spinner)
        spinner.startAnimating()
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        spinner.center = view.center
    }
    
    private func fetchData() {
        viewModel.data { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if result {
                    self.collectionView.reloadData()
                    self.collectionView.isHidden = false
                } else {
                    self.alert(alertTitle: "Error", message: "Something went wrong", actionTitle: "Ok")
                }
                self.spinner.stopAnimating()
            }
        }
    }
    
}
