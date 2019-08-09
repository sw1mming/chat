//
//  LoginProtocols.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/23/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

// MARK: - Business Logic Protocol
protocol LoginInteractorProtocol {
    func loginUser(request: Login.LoginUser.Request)
}

// MARK: - Presentation Protocol
protocol LoginPresenterProtocol {
    func presentLoggedInUser(response: Login.LoginUser.Response)
}

// MARK: - View Protocol
protocol LoginViewProtocol: class {
    func displayLoggedInUser(viewModel: Login.LoginUser.ViewModel)
}
