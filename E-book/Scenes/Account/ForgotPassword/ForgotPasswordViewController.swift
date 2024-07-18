//
//  ForgotPasswordViewController.swift
//  E-book
//
//  Created by Elmar Ibrahimli on 18.07.24.
//

import UIKit
import SnapKit

class ForgotPasswordViewController: UIViewController {
    
    private let viewModel = ForgotPasswordViewModel()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Введи свою электронную почту. Мы отправим тебе письмо со ссылкой для восстановления пароля"
        label.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        label.numberOfLines = 0
        return label
    }()
    
    private let emailLabel = UIAccountLabel(text: "Электронная почта")
    private let emailTextField = UIAccountTextField(placeholder: "E-mail", keyboardType: .emailAddress)
    
    private let confirmBtn = UIFilledButton(title: "Сбросить пароль")
    
    private let spinner = Spinner()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupUI()
    }
    
    private func setupView() {
        title = "Восстановление пароля"
        view.backgroundColor = UIColor(red: 0.99, green: 0.96, blue: 0.95, alpha: 1.00)
        view.addSubview(descriptionLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(confirmBtn)
        view.addSubview(spinner)
        emailTextField.delegate = self
        confirmBtn.addTarget(self, action: #selector(confirmBtnTapped), for: .touchUpInside)
        self.hideKeyboardWhenTappedAround()
    }
    
    private func setupUI() {
        
        descriptionLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-80)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
        spinner.center = view.center
        
    }
    
    @objc private func confirmBtnTapped() {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespaces), !email.isEmpty
        else {
            alert(alertTitle: "Error", message: "Email can not be empty", actionTitle: "OK")
            return
        }
        spinner.startAnimating()
        viewModel.forgotPassword(email: email) {[weak self] result in
            if result {
                self?.alert(alertTitle: "Success", message: "We sent a mail for reset password", actionTitle: "OK")
            }
            else {
                self?.alert(alertTitle: "Error", message: "Email is wrong", actionTitle: "OK")
            }
            self?.spinner.stopAnimating()
        }
    }

}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.56, green: 0.16, blue: 0.07, alpha: 1.00).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.92, green: 0.90, blue: 0.91, alpha: 1.00).cgColor
    }
    
}
