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

    init(text: String?, id: String?, ownerId: String?, recipientId: String?) {
        self.text = text
        self.id = id
        self.ownerId = ownerId
        self.recipientId = recipientId
    }
}
