//
//  LoginInteractor.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/23/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation
import Firebase

class LoginInteractor {
    
    private let presenter: LoginPresenterProtocol
    
    deinit {
        print("!!! LoginInteractor deinit !!!")
    }
    
    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
}

extension LoginInteractor: LoginInteractorProtocol {
    
    func loginUser(request: Login.LoginUser.Request) {
        guard let email = request.email, let password = request.password else { return }
        LoginUserWorker().login(email: email, password: password) { [weak self] error in
            let response = Login.LoginUser.Response(error: CommonError(message: error?.localizedDescription))
            self?.presenter.presentLoggedInUser(response: response)
        }
    }
}
