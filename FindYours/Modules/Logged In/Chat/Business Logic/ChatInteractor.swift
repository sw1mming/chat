//
//  ChatInteractor.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/18/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

class ChatInteractor {
    
    private let presenter: ChatPresenterProtocol
    private let recipientUser: UserModel
    private var messages = [MessageModel]()
    private let messagesManager: MessagesDatabaseManager
    deinit {
        print("!!! ChatInteractor deinit !!!")
    }
    init(presenter: ChatPresenterProtocol, recipientUser: UserModel, messagesManager: MessagesDatabaseManager) {
        self.presenter = presenter
        self.recipientUser = recipientUser
        self.messagesManager = messagesManager
    }
}

extension ChatInteractor: ChatInteractorProtocol {

    func loadMessages(request: Chat.LoadMessages.Request) {
        messagesManager.loadAllMessagesFor(userId: recipientUser.id!) { [weak self] messages, error in
            guard let `self` = self else { return }
            self.messages = messages
            let lastIndexPath = IndexPath(row: self.messages.count - 1, section: 0)
            let response = Chat.LoadMessages.Response(recipientUserName: self.recipientUser.fullName ?? "",
                                                      messages: messages,
                                                      scrollIndexPath: lastIndexPath,
                                                      error: CommonError(message: error?.localizedDescription))
            self.presenter.presentMessages(response: response)
        }
    }
    
    func sendMessage(request: Chat.SendMessage.Request) {
        let message = MessageModel(text: request.messageText,
                                   ownerId: AccountController.instance.currentUser?.id ?? "",
                                   recipientId: recipientUser.id)
        message.createdTimestamp = Double(Date().timeIntervalSince1970)
        messagesManager.send(message: message, completion: { [weak self] error in
            let response = Chat.SendMessage.Response(error: CommonError(message: error?.localizedDescription))
            self?.presenter.presentSendMessage(response: response)
        })
    }
    
    func subscribeOnMessageUpdates(request: Chat.SubscribeMessageUpdates.Request) {
        messagesManager.subscribeMessagesUpdatesFor(userId: recipientUser.id!) { [weak self] msg, error in
            guard let `self` = self else { return }
            if let message = msg, self.messages.contains(where: { $0.id == message.id }) == false {
                self.messages.append(message)
                let lastIndexPath = IndexPath(row: self.messages.count - 1, section: 0)
                let response = Chat.SubscribeMessageUpdates.Response(recipientUserName: self.recipientUser.fullName ?? "",
                                                                     newMessage: message,
                                                                     scrollIndexPath: lastIndexPath,
                                                                     error: CommonError(message: error?.localizedDescription))
                self.presenter.presentMessageUpdates(response: response)
            }
        }
    }
}
