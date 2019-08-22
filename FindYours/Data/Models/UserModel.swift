//
//  UserModel.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/6/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

class UserModel: Codable {
    
    enum CodingKeys: String, CodingKey { case userId, email, userFullName }

    var id: String?
    var email: String?
    var fullName: String?

    init(id: String?, email: String?, fullName: String?) {
        self.id = id
        self.email = email
        self.fullName = fullName
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .userId)
        self.email    = try container.decodeIfPresent(String.self, forKey: .email)
        self.fullName    = try container.decodeIfPresent(String.self, forKey: .userFullName)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .userId)
        try container.encode(email, forKey: .email)
        try container.encode(fullName, forKey: .userFullName)
    }
}
