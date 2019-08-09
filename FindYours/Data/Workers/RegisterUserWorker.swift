//
//  RegisterUserWorker.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/8/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation
import Firebase

class RegisterUserWorker {
    
    func register(fullName: String, email: String, password: String, completion: @escaping (Error?)->()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let id = authResult?.user.uid, error == nil else {
                completion(error!)
                return
            }
            let model = DatabaseManager.UserDataModel(fullName: fullName, id: id, email: email)
            DatabaseManager.instance.save(user: model, completion: { error in
                AccountController.instance.currentUser = UserModel(model: model)
                completion(error)
            })
        }
    }
}
