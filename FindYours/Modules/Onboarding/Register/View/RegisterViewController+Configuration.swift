//
//  RegisterViewController+Configuration.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/31/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

extension RegisterViewController {
    
    func setupView() {
        title = "Register"
        view = RegisterView()
        setupActions()
    }
    
    private func setupActions() {
        registerView.fullNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        registerView.fullNameTextField.addTarget(self, action: #selector(didTapReturnButton), for: .editingDidEndOnExit)
        
        registerView.emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        registerView.emailTextField.addTarget(self, action: #selector(didTapReturnButton), for: .editingDidEndOnExit)
        
        registerView.passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        registerView.passwordTextField.addTarget(self, action: #selector(didTapReturnButton), for: .editingDidEndOnExit)
        
        registerView.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        registerView.setEnableConfirmButton()
    }
    
    @objc private func didTapConfirmButton() {
        startActivityIndicator()
        let request = Register.RegisterUser.Request(fullName: registerView.fullNameTextField.text,
                                                    email: registerView.emailTextField.text,
                                                    password: registerView.passwordTextField.text)
        interactor.registerUser(request: request)
    }
    
    @objc private func didTapReturnButton(textField: UITextField) {
        guard let name = registerView.fullNameTextField.text, !name.isEmpty else {
            let alert = UIAlertController(title: "Warning !!!", message: "Enter full name, please.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return
        }
        
        switch textField {
        case registerView.fullNameTextField:
            registerView.emailTextField.becomeFirstResponder()
        case registerView.emailTextField:
            registerView.passwordTextField.becomeFirstResponder()
        case registerView.passwordTextField:
            registerView.passwordTextField.resignFirstResponder()
            didTapConfirmButton()
        default: break }
    }
}
