//
//  LoginViewController+Configuration.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/23/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

extension LoginViewController {
    
    func setupView() {
        title = "Login"
        view = LoginView()
        setupActions()
    }
    
    private func setupActions() {
        loginView.emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginView.passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginView.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        loginView.setEnableConfirmButton()
    }
    
    @objc private func didTapConfirmButton() {
        startActivityIndicator()
        let request = Login.LoginUser.Request(email: loginView.emailTextField.text,
                                              password: loginView.passwordTextField.text)
        interactor.loginUser(request: request)
    }
    
    @objc private func didTapRegisterButton() {
        navigationController?.pushViewController(RegisterBuilder().build(), animated: true)
    }
}
