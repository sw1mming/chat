//
//  RegisterPresenter.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/31/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

class RegisterPresenter {
    
    deinit {
        print("!!! RegisterPresenter deinit !!!")
    }
    
    private weak var view: RegisterViewProtocol!
    func set(_ view: RegisterViewProtocol) { self.view = view }
}

extension RegisterPresenter: RegisterPresenterProtocol {
    
    func presentRegisteredUser(response: Register.RegisterUser.Response) {
        let viewModel = Register.RegisterUser.ViewModel(error: response.error)
        view.displayRegisteredUser(viewModel: viewModel)
    }
}
