//
//  BooksViewController.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 09.08.24.
//

import UIKit
import SnapKit

class BooksViewController: UIViewController {
    
    private let categoryId: String?
    private let recommendedBooks: Bool
    private let newBooks: Bool
    private let spinner = Spinner()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
        tv.separatorStyle = .none
        return tv
    }()
    
    internal let viewModel = BooksViewModel()
    
    init(categoryId: String? = nil, title: String? = nil, recommendedBooks: Bool = false, newBooks: Bool = false) {
        self.categoryId = categoryId
        self.recommendedBooks = recommendedBooks
        self.newBooks = newBooks
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        fetchData()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 0.99, green: 0.96, blue: 0.95, alpha: 1.00)
        tableView.backgroundColor = view.backgroundColor
        view.addSubview(tableView)
        view.addSubview(spinner)
        tableView.delegate = self
        tableView.dataSource = self
        spinner.startAnimating()
    }
    
    private func setupConstraints() {
        tableView.frame = view.bounds
        spinner.center = view.center
    }
    
    private func fetchData() {
        viewModel.data { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if result {
                    self.tableView.reloadData()
                } else {
                    self.alert(alertTitle: "Error", message: "Something went wrong", actionTitle: "Ok")
                }
                self.spinner.stopAnimating()
            }
        }
    }

}
