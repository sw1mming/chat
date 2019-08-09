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
        registerView.emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        registerView.passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
}
