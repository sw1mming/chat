//
//  LoginPresenter.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/23/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

class LoginPresenter {
    
    private weak var view: LoginViewProtocol!
    func set(_ view: LoginViewProtocol) { self.view = view }
}

extension LoginPresenter: LoginPresenterProtocol {
    
    func presentLoggedInUser(response: Login.LoginUser.Response) {
        let viewModel = Login.LoginUser.ViewModel(result: response.result)
        view.displayLoggedInUser(viewModel: viewModel)
    }
}
