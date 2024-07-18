//
//  WelcomeViewController.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 19.04.24.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    private let viewModel = WelcomeViewModel()
    private let spinner = Spinner()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isPagingEnabled = true
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00)
        pc.pageIndicatorTintColor = UIColor(red: 1.00, green: 0.84, blue: 0.80, alpha: 1.00)
        pc.currentPage = 0
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUI()
        fetchData()
        spinner.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func pageControlChange(_ sender: UIPageControl) {
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            self?.scrollView.contentOffset = CGPoint(x: sender.currentPage * Int(self?.view.frame.width ?? 0), y: 0)
        })
    }
    
    private func setupView() {
          view.backgroundColor = UIColor(red: 0.99, green: 0.96, blue: 0.95, alpha: 1.00)
          view.addSubview(scrollView)
          view.addSubview(spinner)
          view.addSubview(pageControl)
          pageControl.addTarget(self, action: #selector(pageControlChange(_:)), for: .valueChanged)
          scrollView.delegate = self
      }
    
    private func setupUI() {
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-12)
        }
        spinner.center = view.center
    }
    
    private func fetchData() {
        viewModel.data { [weak self] result in
            guard let self = self else { return }
            self.spinner.stopAnimating()
            if result {
                self.setupScrollViewContent()
            } else {
                self.alert(alertTitle: "Error", message: "Something went wrong", actionTitle: "OK")
            }
        }
    }
    
    private func setupScrollViewContent() {
        let count = viewModel.dataSource.count
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(count + 1), height: scrollView.frame.height)
        pageControl.numberOfPages = count + 1
        
        for (index, data) in viewModel.dataSource.enumerated() {
            let subView = createContentSubview(with: data, width: scrollView.frame.width)
            scrollView.addSubview(subView)
            
            subView.snp.makeConstraints { make in
                make.height.width.equalToSuperview()
                make.left.equalToSuperview().offset(scrollView.frame.width * CGFloat(index))
            }
        }
        let lastView = UIView()
        
        let imageView = UIImageView(image: UIImage(named: "writing"))
        imageView.contentMode = .scaleAspectFit
        
        let label = createLabel(text: "Читай. Переводи. Создавай заметки", font: .boldSystemFont(ofSize: 28))
        
        let text = "Читай. Переводи. Создавай заметки"
        let titleLabelText = NSMutableAttributedString(string: text)
        if let rangeOfLastWord = text.range(of: "Читай. Переводи.")
        {
            let nsRange = NSRange(rangeOfLastWord, in: text)
            titleLabelText.addAttribute(.foregroundColor, value: UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00), range: nsRange)
        }
        label.attributedText = titleLabelText
        
        let registerButton = UIFilledButton(title: "Зарегистрироваться")
        
        let loginButton = UIBorderedButton(title: "Войти")
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        lastView.addSubview(imageView)
        lastView.addSubview(label)
        lastView.addSubview(registerButton)
        lastView.addSubview(loginButton)
        scrollView.addSubview(lastView)
        
        lastView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            make.left.equalToSuperview().offset(scrollView.frame.width * CGFloat(count))
        }
        
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
            make.bottom.equalTo(label.snp.top)
        }
        
        loginButton.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-48)
            make.centerX.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(48)
            make.bottom.equalTo(loginButton.snp.top).offset(-12)
            make.centerX.equalToSuperview()
        }
        
    }
    
    private func createContentSubview(with data: Welcome, width: CGFloat) -> UIView {
        let subView = UIView()
        
        let titleLabel = createLabel(text: data.title, font: .boldSystemFont(ofSize: 28))
        let descriptionLabel = createLabel(text: data.descriptrion, font: .systemFont(ofSize: UIFont.systemFontSize))
        
        let titleLabelText = NSMutableAttributedString(string: data.title)
        if let rangeOfLastWord = data.title.range(of: data.title.components(separatedBy: " ").last ?? "") 
        {
            let nsRange = NSRange(rangeOfLastWord, in: data.title)
            titleLabelText.addAttribute(.foregroundColor, value: UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00), range: nsRange)
        }
        titleLabel.attributedText = titleLabelText
        
        subView.addSubview(titleLabel)
        subView.addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().offset(-50)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-50)
        }
        
        return subView
    }
    
    private func createLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }
    
    @objc private func loginButtonTapped() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc private func registerButtonTapped() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
}

extension WelcomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
