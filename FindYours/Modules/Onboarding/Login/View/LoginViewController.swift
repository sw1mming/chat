//
//  Login.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/23/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginView: LoginView { return view as! LoginView }
    
    let interactor: LoginInteractorProtocol
    
    deinit {
        print("!!! LoginViewController deinit !!!")
    }
    
    init(interactor: LoginInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() { setupView() }
}

extension LoginViewController: LoginViewProtocol {
    
    func displayLoggedInUser(viewModel: Login.LoginUser.ViewModel) {
        stopActivityIndicator()
        if let error = viewModel.error {
            let alert = UIAlertController(title: "You are not logged in !!!", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ":(", style: .default))
            present(alert, animated: true)
        } else {
            appDelegate.window?.rootViewController = TabBarController()
        }
    }
}
