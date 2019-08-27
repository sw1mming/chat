//
//  RegisterProtocols.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/31/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

// MARK: - Business Logic Protocol
protocol RegisterInteractorProtocol {
    func registerUser(request: Register.RegisterUser.Request)
    func chooseAvatar(request: Register.ChooseAvatar.Request)
}

// MARK: - Presentation Protocol
protocol RegisterPresenterProtocol {
    func presentRegisteredUser(response: Register.RegisterUser.Response)
    func presentChoosedAvatar(request: Register.ChooseAvatar.Response)
}

// MARK: - View Protocol
protocol RegisterViewProtocol: class {
    func displayRegisteredUser(viewModel: Register.RegisterUser.ViewModel)
    func displayChoosesAvatar(request: Register.ChooseAvatar.ViewModel)
}
