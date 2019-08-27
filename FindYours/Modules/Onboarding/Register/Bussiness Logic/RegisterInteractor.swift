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
    
    private var avatarData: Data?
    
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
        RegisterUserWorker().register(fullName: fullName, email: email, password: password, avatarImageData: avatarData) { [weak self] error in
            let response = Register.RegisterUser.Response(error: CommonError(message: error?.localizedDescription))
            self?.presenter.presentRegisteredUser(response: response)
        }
    }
    
    func chooseAvatar(request: Register.ChooseAvatar.Request) {
        if let avatarImage = request.image {
            avatarData = avatarImage.jpegData(compressionQuality: 1.0)
            presenter.presentChoosedAvatar(request: Register.ChooseAvatar.Response(error: nil))
        } else {
            presenter.presentChoosedAvatar(request: Register.ChooseAvatar.Response(error: nil))
        }
    }
}
