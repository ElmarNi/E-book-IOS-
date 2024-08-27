//
//  BottomSheetViewController.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 26.08.24.
//

import UIKit
import SnapKit

class BottomSheetViewController: UIViewController, UISheetPresentationControllerDelegate {
    
    let book: BookShortInfo
    let hasBook: Bool
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Управление книгой"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        segmentControl.backgroundColor = .white
        segmentControl.selectedSegmentTintColor = UIColor(red: 1.00, green: 0.84, blue: 0.80, alpha: 1.00)
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00)], for: .selected)
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00)], for: .normal)
        return segmentControl
    }()
    
    private let saveButton = UIFilledButton(title: "Сохранить")
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
    
    init(book: BookShortInfo) {
        self.book = book
        self.hasBook = book.hasBook ?? false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        hideSegmentControlBackground(segmentControl)
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 0.99, green: 0.96, blue: 0.95, alpha: 1.00)
        sheetPresentationController?.delegate = self
        sheetPresentationController?.detents = [.medium()   ]
        sheetPresentationController?.prefersGrabberVisible = true
        
        book.status?.forEach { status in
            segmentControl.insertSegment(withTitle: status.name, at: segmentControl.numberOfSegments, animated: false)
        }
        segmentControl.selectedSegmentIndex = book.status?.firstIndex(where: { $0.active }) ?? 0
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 16
        tableView.clipsToBounds = true
        view.addSubview(titleLabel)
        view.addSubview(segmentControl)
        view.addSubview(tableView)
        view.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24)
        }
        
        segmentControl.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.height.equalTo(100)
        }
        
        saveButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(48)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(segmentControl.snp.bottom).offset(33)
            make.bottom.equalTo(saveButton.snp.top).offset(-33)
        }
    }
    
    private func hideSegmentControlBackground(_ segmentControl: UISegmentedControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            for i in 0...(segmentControl.numberOfSegments-1)  {
                let backgroundSegmentView = segmentControl.subviews[i]
                backgroundSegmentView.isHidden = true
            }
        }
    }
    
    @objc private func saveButtonTapped() {
        dismiss(animated: true)
    }
    
}

extension BottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.row {
        case 0: cell.textLabel?.text = book.hasBook ?? false ? "Удалить из моих книг" : "Добавить книгу на полку"
        case 1: cell.textLabel?.text = "Поделиться"
        default: cell.textLabel?.text = "Скачать книгу"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            alert(alertTitle: "Message", message: hasBook ? "Book removed" : "Book added", actionTitle: "OK")
        case 1:
            alert(alertTitle: "Message", message: "Book saved", actionTitle: "OK")
        default: alert(alertTitle: "Message", message: "Book downloading to documents", actionTitle: "OK")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
}
