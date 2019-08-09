//
//  LoginBuilder.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/23/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class LoginBuilder {

    func build() -> UIViewController {
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(presenter: presenter)
        let view = LoginViewController(interactor: interactor)
        presenter.set(view)
        
        return UINavigationController(rootViewController: view)
    }
}
