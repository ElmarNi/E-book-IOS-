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
    
    private let segmentControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Книги", "Аудиокниги"])
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = .white
        sc.selectedSegmentTintColor = UIColor(red: 1.00, green: 0.84, blue: 0.80, alpha: 1.00)
        sc.setTitleTextAttributes([.foregroundColor: UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00)], for: .selected)
        sc.setTitleTextAttributes([.foregroundColor: UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00)], for: .normal)
        return sc
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = HomeViewController.createCompositionalLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        cv.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        cv.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        hideSegmentControlBackground(segmentControl)
        fetchData()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 0.99, green: 0.96, blue: 0.95, alpha: 1.00)
        collectionView.backgroundColor = view.backgroundColor
        
        title = "Книги для тебя"
        view.addSubview(segmentControl)
        view.addSubview(collectionView)
        view.addSubview(spinner)
        spinner.startAnimating()
    }
    
    private func setupConstraints() {
        segmentControl.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(36)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        spinner.center = view.center
    }
    
    private func hideSegmentControlBackground(_ segmentControl: UISegmentedControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            for i in 0...(segmentControl.numberOfSegments-1)  {
                let backgroundSegmentView = segmentControl.subviews[i]
                backgroundSegmentView.isHidden = true
            }
        }
    }
    
    private func fetchData() {
        viewModel.data(type: .book) { [weak self] result in
            guard let self = self else { return }
            if result {
                self.collectionView.reloadData()
            } else {
                self.alert(alertTitle: "Error", message: "Something went wrong", actionTitle: "Ok")
            }
            self.spinner.stopAnimating()
        }
    }
    
    @objc private func segmentControlValueChanged(_ sender: UISegmentedControl) {
        
    }
    
}
