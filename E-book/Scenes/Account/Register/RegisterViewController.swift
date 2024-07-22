//
//  RegisterViewController.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 18.07.24.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController {

    private let viewModel = RegisterViewModel()
    
    private let emailLabel = UIAccountLabel(text: "Электронная почта")
    private let emailTextField = UIAccountTextField(placeholder: "E-mail", keyboardType: .emailAddress)
    
    private let passwordLabel = UIAccountLabel(text: "Пароль")
    private let passwordTextField = UIAccountTextField(placeholder: "Введите пароль", isSecureTextEntry: true)
    
    private let confirmPasswordLabel = UIAccountLabel(text: "Подтверди пароль")
    private let confirmPasswordTextField = UIAccountTextField(placeholder: "Введите пароль", isSecureTextEntry: true)
    
    private let hasAccountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: UIFont.systemFontSize)
        let attributedString = NSMutableAttributedString(string: "Уже есть аккаунт? Войти")
        let linkRange = (attributedString.string as NSString).range(of: "Войти")

        let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00),
            .font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        ]

        attributedString.setAttributes(linkAttributes, range: linkRange)

        label.attributedText = attributedString
        return label
    }()
    
    private let spinner = Spinner()
    
    private let registerBtn = UIFilledButton(title: "Создать аккаунт")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupUI()
    }
    
    private func setupView() {
        title = "Создание аккаунта"
        view.backgroundColor = UIColor(red: 0.99, green: 0.96, blue: 0.95, alpha: 1.00)
        
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordLabel)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(hasAccountLabel)
        view.addSubview(registerBtn)
        
        view.addSubview(spinner)
        self.hideKeyboardWhenTappedAround()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        emailTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .next
        
        emailTextField.tag = 0
        passwordTextField.tag = 1
        confirmPasswordTextField.tag = 2

        registerBtn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hasAccountLabelTapped))
        hasAccountLabel.addGestureRecognizer(tap)
    }
    
    private func setupUI() {
        emailLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
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
        
        confirmPasswordLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(confirmPasswordLabel.snp.bottom).offset(8)
        }
        
        hasAccountLabel.snp.makeConstraints { make in
            make.width.lessThanOrEqualToSuperview().offset(-80)
            make.left.equalTo(40)
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(16)
        }
        
        registerBtn.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
        spinner.center = view.center
    }
    
    @objc private func registerBtnTapped() {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespaces), !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty
        else {
            alert(alertTitle: "Error", message: "All fields are required", actionTitle: "OK")
            return
        }
        
        if confirmPassword != password {
            alert(alertTitle: "Error", message: "Passwords does not match", actionTitle: "OK")
            return
        }
        
        spinner.startAnimating()
        view.isUserInteractionEnabled = false
        viewModel.register(email: email, password: password) { [weak self] result in
            if let result = result, result.success {
                UserDefaults.standard.setValue(result.clientID, forKey: "clientID")
                self?.navigationController?.setViewControllers([HomeViewController()], animated: true)
            }
            else {
                self?.alert(alertTitle: "Error", message: "Something went wrong. Try again.", actionTitle: "OK")
            }
            self?.spinner.stopAnimating()
            self?.view.isUserInteractionEnabled = true
        }
    }
    
    @objc private func hasAccountLabelTapped (_ gesture: UITapGestureRecognizer) {
        guard let text = hasAccountLabel.text else { return }
        
        let specifiedWordRange = (text as NSString).range(of: "Войти")
        
        if gesture.didTapAttributedTextInLabel(label: hasAccountLabel, inRange: specifiedWordRange) {
            navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == 0 {
            passwordTextField.becomeFirstResponder()
            return false
        }
        else if textField.tag == 1 {
            confirmPasswordTextField.becomeFirstResponder()
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
