//
//  RegisterViewController.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/31/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var registerView: RegisterView { return view as! RegisterView }
    
    let interactor: RegisterInteractorProtocol
    
    init(interactor: RegisterInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() { setupView() }
}

extension RegisterViewController: RegisterViewProtocol {
    
    func displayRegisteredUser(viewModel: Register.RegisterUser.ViewModel) {
        if let error = viewModel.error {
            let alert = UIAlertController(title: "User not created !!!", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ":(", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Congrats !!!", message: "User has created !!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ":)", style: .default, handler: { action in
                appDelegate.window?.rootViewController = TabBarController()
            }))
            present(alert, animated: true)
            registerView.clearFields()
        }
    }
}
