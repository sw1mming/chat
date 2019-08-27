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
    
    func register(fullName: String, email: String, password: String, avatarImageData: Data?, completion: @escaping (Error?)->()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let id = authResult?.user.uid, error == nil else {
                completion(error!)
                return
            }
            
            let user = UserModel(id: id, email: email, fullName: fullName, avatarUrlString: nil)
            DatabaseManager.instance.save(user: user, avatarImageData: avatarImageData, completion: { savedUser, error in
                if error == nil {
                    AccountController.instance.currentUser = savedUser
                }
                completion(error)
            })
        }
    }
}
