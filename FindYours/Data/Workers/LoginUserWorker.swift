//
//  LoginUserWorker.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/8/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation
import Firebase

class LoginUserWorker {
    
    func login(email: String, password: String, completion: @escaping (Error?)->()) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let result = result, error == nil {
                getUserFromDatabase(userId: result.user.uid)
            } else if let error = error {
                completion(error)
            }
        }
        
        func getUserFromDatabase(userId: String) {
            UsersDataManager.instance.getUser(id: userId, completion: { user in
                if let user = user {
                    AccountController.instance.currentUser = user
                    completion(nil)
                } else {
                    completion(NSError(domain: "DB does not have this user.", code: 0, userInfo: nil))
                }
            })
        }
    }
}
