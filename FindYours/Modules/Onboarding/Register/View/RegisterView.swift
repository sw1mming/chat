//
//  RegisterView.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/31/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class RegisterView: UIView {
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        
        return imageView
    }()
    
    let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.placeholder = "Full name"
        textField.enablesReturnKeyAutomatically = true
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
        
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.placeholder = "Email"
        textField.autocapitalizationType = .none
        textField.enablesReturnKeyAutomatically = true
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
        
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.placeholder = "Password"
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.enablesReturnKeyAutomatically = true
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        
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
        
        addSubview(avatarImageView)
        addSubview(fullNameTextField)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 150),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),

            fullNameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            fullNameTextField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            fullNameTextField.heightAnchor.constraint(equalToConstant: 50),
            fullNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            fullNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 10),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            confirmButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 40),
            confirmButton.widthAnchor.constraint(equalToConstant: 100)
        ])
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
