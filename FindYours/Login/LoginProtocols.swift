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
    
}

// MARK: - View Protocol
protocol LoginViewProtocol: class {
    
}
