//
//  UserModel.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/6/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

class UserModel {
    
    var id: String?
    var email: String?
    var fullName: String?

    init(id: String?, email: String?, fullName: String?) {
        self.id = id
        self.email = email
        self.fullName = fullName
    }
}

extension UserModel {
    
    convenience init(model: DatabaseManager.UserDataModel) {
        self.init(id: model.id,
                  email: model.email,
                  fullName: model.fullName)
    }
}
