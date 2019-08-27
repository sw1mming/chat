//
//  UserModel.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/6/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

class UserModel: Codable {
    
    enum CodingKeys: String, CodingKey { case userId, email, userFullName, avatarUrlString }

    var id: String?
    var email: String?
    var fullName: String?
    var avatarUrlString: String?
    var avatarUrl: URL? { return avatarUrlString != nil ? URL(string: avatarUrlString!) : nil }
    
    init(id: String?, email: String?, fullName: String?, avatarUrlString: String?) {
        self.id = id
        self.email = email
        self.fullName = fullName
        self.avatarUrlString = avatarUrlString
    }
    
    required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        id              = try container.decodeIfPresent(String.self, forKey: .userId)
        email           = try container.decodeIfPresent(String.self, forKey: .email)
        fullName        = try container.decodeIfPresent(String.self, forKey: .userFullName)
        avatarUrlString = try container.decodeIfPresent(String.self, forKey: .avatarUrlString)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .userId)
        try container.encode(email, forKey: .email)
        try container.encode(fullName, forKey: .userFullName)
        try container.encode(avatarUrlString, forKey: .avatarUrlString)
    }
}
