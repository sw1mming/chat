//
//  RegisterInteractor.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/31/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation
import Firebase

class RegisterInteractor {
    
    private let presenter: RegisterPresenterProtocol
    
    deinit {
        print("!!! RegisterInteractor deinit !!!")
    }

    init(presenter: RegisterPresenterProtocol) {
        self.presenter = presenter
    }
}

extension RegisterInteractor: RegisterInteractorProtocol {
    
    func registerUser(request: Register.RegisterUser.Request) {
        guard let fullName = request.fullName, let email = request.email, let password = request.password else {
            let response = Register.RegisterUser.Response(error: CommonError(message: "Some registration fields are missing."))
            presenter.presentRegisteredUser(response: response)
            return
        }
        RegisterUserWorker().register(fullName: fullName, email: email, password: password) { [weak self] error in
            let response = Register.RegisterUser.Response(error: CommonError(message: error?.localizedDescription))
            self?.presenter.presentRegisteredUser(response: response)
        }
    }
}
