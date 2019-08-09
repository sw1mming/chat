//
//  RegisterView.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/31/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class RegisterView: UIView {

    let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.placeholder = "Full name"
        
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.placeholder = "Email"
        
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.placeholder = "Password"
        
        return textField
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        
        return button
    }()
    
    deinit {
        print("!!! RegisterView deinit !!!")
    }
    
    init() {
        super.init(frame: .zero)
        print()
        backgroundColor = .white
        
        addSubview(fullNameTextField)
        fullNameTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fullNameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 200).isActive = true
        fullNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        fullNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        fullNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        addSubview(emailTextField)
        emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 10).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        addSubview(passwordTextField)
        passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        addSubview(confirmButton)
        confirmButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        confirmButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        confirmButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        setEnableConfirmButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setEnableConfirmButton() {
        let isEnabled = fullNameTextField.text?.isEmpty == true ||
            emailTextField.text?.isEmpty == true ||
            passwordTextField.text?.isEmpty == true
        confirmButton.isEnabled = !isEnabled
    }
    
    func clearFields() {
        fullNameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        setEnableConfirmButton()
    }
}
