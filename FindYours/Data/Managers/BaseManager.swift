//
//  BaseManager.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/27/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation
import Firebase

class BaseManager {
    enum DatabaseKey {
        static let users = "users"
        static let messages = "messages"
    }
    
    static let baseDatabase = Firestore.firestore()
}
