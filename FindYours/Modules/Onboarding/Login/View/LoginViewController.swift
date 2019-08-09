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
    
    init(interactor: LoginInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login"
    }
    
    override func loadView() { setupView() }
}

extension LoginViewController: LoginViewProtocol {
    
    func displayLoggedInUser(viewModel: Login.LoginUser.ViewModel) {
        appDelegate.window?.rootViewController = TabBarController()
    }
}
