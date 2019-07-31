//
//  LoginInteractor.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/23/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class LoginInteractor {
    
    private let presenter: LoginPresenterProtocol
    
    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
}

extension LoginInteractor: LoginInteractorProtocol {
    
    func loginUser(request: Login.LoginUser.Request) {
        guard let email = request.email, let password = request.password else { return }
//        Auth.auth().createUser(withEmail: email, password: password) { (res, error) in
//            print()
//        }
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//            print()
//            let ref: DatabaseReference = Database.database().reference()
//            let fullName = ["First-name": "Firebase" , "Last-name": "Demo"]
//            ref.child("users").child((result?.user.uid)!).setValue(["fullName": fullName], withCompletionBlock: { (error, ref) in
//                print()
//            })//setValue(["fullName": fullName])
//
//        }

//         Database.database().reference().child("USERS_INFO").observe(.childAdded, with: { (snapshot) in
//            print()
//         })
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let userId = authResult?.user.uid else { return }
            let ref: DatabaseReference = Database.database().reference()
            let usersRef = ref.child("users").child("oErg1Gp6JGdIrWUi8idV")
            let values = ["email" : email]
            
            usersRef.updateChildValues(values) { (error, dRef) in
                print()
            }
        }
    }
}
