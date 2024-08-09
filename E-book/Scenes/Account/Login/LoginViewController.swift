//
//  LoginViewController.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 16.07.24.
//

import UIKit
import GoogleSignIn
import SnapKit
import FirebaseCore

class LoginViewController: UIViewController {

    private let viewModel = LoginViewModel()
    
    private let signInWithGoogleBtn = UIBorderedButton(title: "Продолжить с Google")
    
    private let signInBtn = UIFilledButton(title: "Войти")
    
    private let spinner = Spinner()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "или"
        label.textColor = UIColor(red: 0.32, green: 0.30, blue: 0.30, alpha: 1.00)
        label.font = .systemFont(ofSize: UIFont.systemFontSize)
        return label
    }()
    private let leftLine = UIView()
    private let rightLine = UIView()
    
    private let emailLabel = UIAccountLabel(text: "Электронная почта")
    private let emailTextField = UIAccountTextField(placeholder: "E-mail", keyboardType: .emailAddress)
    
    private let passwordLabel = UIAccountLabel(text: "Пароль")
    private let passwordTextField = UIAccountTextField(placeholder: "Введите пароль", isSecureTextEntry: true)
    
    private let forgotPasswordBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Забыли пароль?", for: .normal)
        btn.setTitleColor(UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
        return btn
    }()
    
    private let notAccountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: UIFont.systemFontSize)
        let attributedString = NSMutableAttributedString(string: "Еще нет аккаунта? Зарегистрироваться")
        let linkRange = (attributedString.string as NSString).range(of: "Зарегистрироваться")

        let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00),
            .font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        ]

        attributedString.setAttributes(linkAttributes, range: linkRange)

        label.attributedText = attributedString
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUI()
        configureGoogleSignIn()
    }
    
    private func setupView() {
        title = "Вход"
        view.backgroundColor = UIColor(red: 0.99, green: 0.96, blue: 0.95, alpha: 1.00)
        view.addSubview(signInWithGoogleBtn)
        view.addSubview(orLabel)
        view.addSubview(leftLine)
        view.addSubview(rightLine)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordBtn)
        view.addSubview(notAccountLabel)
        view.addSubview(signInBtn)
        view.addSubview(spinner)
        self.hideKeyboardWhenTappedAround()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.returnKeyType = .next
        emailTextField.tag = 0
        passwordTextField.tag = 1
        leftLine.backgroundColor = UIColor(red: 0.87, green: 0.85, blue: 0.85, alpha: 1.00)
        rightLine.backgroundColor = UIColor(red: 0.87, green: 0.85, blue: 0.85, alpha: 1.00)
        signInBtn.addTarget(self, action: #selector(signInBtnTapped), for: .touchUpInside)
        forgotPasswordBtn.addTarget(self, action: #selector(forgotPasswordBtnTapped), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(notAccountLabelTapped))
        notAccountLabel.addGestureRecognizer(tap)
        setupSignInWithGoogleBtn()
    }
    
    private func setupUI() {
        signInWithGoogleBtn.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        orLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signInWithGoogleBtn.snp.bottom).offset(16)
        }
        
        leftLine.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(orLabel.snp.left).offset(-32)
            make.height.equalTo(2)
            make.centerY.equalTo(orLabel.snp.centerY)
        }
        
        rightLine.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.left.equalTo(orLabel.snp.right).offset(32)
            make.height.equalTo(2)
            make.centerY.equalTo(orLabel.snp.centerY)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.top.equalTo(orLabel.snp.bottom).offset(16)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
        }
        
        forgotPasswordBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
        }
        
        notAccountLabel.snp.makeConstraints { make in
            make.width.lessThanOrEqualToSuperview().offset(-80)
            make.left.equalTo(40)
            make.top.equalTo(forgotPasswordBtn.snp.bottom).offset(8)
        }
        
        signInBtn.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
        spinner.center = view.center
        
    }
    
    private func setupSignInWithGoogleBtn() {
        signInWithGoogleBtn.setImage(UIImage(named: "google"), for: .normal)
        signInWithGoogleBtn.imageEdgeInsets.left = -30
        signInWithGoogleBtn.setTitleColor(.label, for: .normal)
        signInWithGoogleBtn.imageView?.layer.transform = CATransform3DMakeScale(2.5, 2.5, 2.5)
        signInWithGoogleBtn.addTarget(self, action: #selector(signInWithGoogleBtnTapped), for: .touchUpInside)
    }
    
    private func configureGoogleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }
    
    @objc private func signInWithGoogleBtnTapped() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            
        }
    }
    
    @objc private func forgotPasswordBtnTapped() {
        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
    
    @objc private func signInBtnTapped() {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespaces), !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            alert(alertTitle: "Error", message: "All fields are required", actionTitle: "OK")
            return
        }
        spinner.startAnimating()
        view.isUserInteractionEnabled = false
        viewModel.login(email: email, password: password) { [weak self] result in
            if let result = result, result.success {
                UserDefaults.standard.setValue(result.clientID, forKey: "clientID")
                self?.navigationController?.setViewControllers([TabBarViewController()], animated: true)
            }
            else {
                self?.alert(alertTitle: "Error", message: "Email or Password are wrong", actionTitle: "OK")
            }
            self?.spinner.stopAnimating()
            self?.view.isUserInteractionEnabled = true
        }
    }
    
    @objc private func notAccountLabelTapped (_ gesture: UITapGestureRecognizer) {
        guard let text = notAccountLabel.text else { return }
        
        let specifiedWordRange = (text as NSString).range(of: "Зарегистрироваться")
        print(specifiedWordRange)
        if gesture.didTapAttributedTextInLabel(label: notAccountLabel, inRange: specifiedWordRange) {
            navigationController?.pushViewController(RegisterViewController(), animated: true)
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == 0 {
            passwordTextField.becomeFirstResponder()
            return false
        }
        else {
            textField.resignFirstResponder()
            return true
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.92, green: 0.90, blue: 0.91, alpha: 1.00).cgColor
    }
    
}

