//
//  MessageModel.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/7/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

class MessageModel {
    
    var text: String?
    var id: String?
    var ownerId: String?
    var recipientId: String?
    var createdTimestamp: NSNumber!

    init(text: String?, id: String? = nil, ownerId: String?, recipientId: String?) {
        self.text = text
        self.id = id
        self.ownerId = ownerId
        self.recipientId = recipientId
        self.createdTimestamp = NSNumber(value: Date().timeIntervalSince1970)
    }
    
    func shouldShowWith(currentUserId: String?, recipientId: String?) -> Bool {
        guard ownerId == recipientId || ownerId == currentUserId &&
            self.recipientId == recipientId || self.recipientId == currentUserId else { return false }
        return true
    }
}
