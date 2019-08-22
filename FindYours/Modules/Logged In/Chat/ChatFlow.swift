//
//  ChatFlow.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/18/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

enum Chat {
    
    struct MessagePresentationModel {
        let userName: String
        let text: String
        let time: String
    }

    enum LoadMessages {
        struct Request {
        }
        
        struct Response {
            let recipientUserName: String
            let messages: [MessageModel]
            let scrollIndexPath: IndexPath
            let error: CommonError?
        }
        
        struct ViewModel {
            let result: MessagesResult
        }
    }
    
    enum SendMessage {
        struct Request {
            let messageText: String
        }
        
        struct Response {
            // Sent message get from listener.
            let error: CommonError?
        }
        
        struct ViewModel {
            let error: CommonError?
        }
    }
    
    enum SubscribeMessageUpdates {
        struct Request {}
        
        struct Response {
            let recipientUserName: String
            let newMessage: MessageModel
            let scrollIndexPath: IndexPath
            let error: CommonError?
        }
        
        struct ViewModel {
            let result: MessageResult
        }
    }
    
    enum MessageResult {
        case result(MessagePresentationModel, IndexPath)
        case error(CommonError)
    }
    
    enum MessagesResult {
        case result([MessagePresentationModel], IndexPath)
        case error(CommonError)
    }
}
