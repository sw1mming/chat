//
//  MessageModel.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/7/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

class MessageModel: Codable {

    enum CodingKeys: String, CodingKey { case messageText, messageId, ownerId, recipientId, createdTimestamp }

    var text: String?
    var id: String?
    var ownerId: String?
    var recipientId: String?
    var createdTimestamp: Double?

    init(text: String?, id: String? = nil, ownerId: String?, recipientId: String?, createdTimestamp: Double? = nil) {
        self.text = text
        self.id = id
        self.ownerId = ownerId
        self.recipientId = recipientId
        self.createdTimestamp = createdTimestamp
    }
    
    func shouldShowWith(currentUserId: String?, recipientId: String?) -> Bool {
        guard
            (self.recipientId == currentUserId && ownerId == recipientId) ||
            (ownerId == currentUserId && self.recipientId == recipientId)
            else { return false } 
        return true
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decodeIfPresent(String.self, forKey: .messageText)
        self.id    = try container.decodeIfPresent(String.self, forKey: .messageId)
        self.ownerId    = try container.decodeIfPresent(String.self, forKey: .ownerId)
        self.recipientId    = try container.decodeIfPresent(String.self, forKey: .recipientId)
        self.createdTimestamp    = try container.decodeIfPresent(Double.self, forKey: .createdTimestamp)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .messageText)
        try container.encode(id, forKey: .messageId)
        try container.encode(ownerId, forKey: .ownerId)
        try container.encode(recipientId, forKey: .recipientId)
        try container.encode(createdTimestamp, forKey: .createdTimestamp)
    }
}
