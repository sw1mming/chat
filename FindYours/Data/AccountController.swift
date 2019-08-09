//
//  AccountController.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/7/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

final class AccountController {
    
    static let instance = AccountController()
    private init() {
        guard let id = userId, let userFullName = userFullName, let email = userEmail else { return }
        currentUser = UserModel(id: id, email: email, fullName: userFullName)
    }
    
    private let userDefaults = UserDefaults.standard
    
    var currentUser: UserModel? {
        didSet {
            userId = currentUser?.id
            userFullName = currentUser?.fullName
            userEmail = currentUser?.email
        }
    }
    
    private var userFullName: String? {
        get {
            return userDefaults.string(forKey: Key.userFullName)
        }
        
        set {
            userDefaults.set(newValue, forKey: Key.userFullName)
        }
    }
    
    private var userId: String? {
        get {
            return userDefaults.string(forKey: Key.userId)
        }
        
        set {
            userDefaults.set(newValue, forKey: Key.userId)
        }
    }
    
    private var userEmail: String? {
        get {
            return userDefaults.string(forKey: Key.userEmail)
        }
        
        set {
            userDefaults.set(newValue, forKey: Key.userEmail)
        }
    }
}

extension AccountController {
    private enum Key {
        static let userFullName = "user_full_name"
        static let userId = "user_id"
        static let userEmail = "user_email"
    }
}
