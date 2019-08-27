//
//  ChatPresenter.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/18/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

class ChatPresenter {
    
    private weak var view: ChatViewProtocol!
    func set(_ view: ChatViewProtocol) { self.view = view }
    deinit {
        print("!!! ChatPresenter deinit !!!")
    }
    private let currentUser = AccountController.instance.currentUser
    private let formater: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    private func convert(messages: [MessageModel],
                         recipientUserName: String,
                         currentUserId: String,
                         currentUserName: String) -> [Chat.MessagePresentationModel] {
        let result = messages.map({ convert(message: $0,
                                            recipientUserName: recipientUserName,
                                            currentUserId: currentUserId,
                                            currentUserName: currentUserName) })
        return result
    }
    
    private func convert(message: MessageModel,
                         recipientUserName: String,
                         currentUserId: String,
                         currentUserName: String) -> Chat.MessagePresentationModel {
        let userName = message.ownerId == currentUserId ? currentUserName : recipientUserName
        
        let time = message.createdTimestamp == nil
            ? ""
            : formater.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: message.createdTimestamp!) ?? 0))
        let viewModel = Chat.MessagePresentationModel(userName: userName,
                                                      text: message.text!,
                                                      time: time)
        return viewModel
    }
}

extension ChatPresenter: ChatPresenterProtocol {
    
    func presentMessages(response: Chat.LoadMessages.Response) {
        guard let currentUserId = currentUser?.id, let currentUserName = currentUser?.fullName, response.error == nil else {
            let viewModel = Chat.LoadMessages.ViewModel(result: .error(CommonError(message: "Can't present messages.")!))
            view.displayMessages(viewModel: viewModel)
            return
        }
        let messageViewModels = convert(messages: response.messages,
                                        recipientUserName: response.recipientUserName,
                                        currentUserId: currentUserId,
                                        currentUserName: currentUserName)
        let viewModel = Chat.LoadMessages.ViewModel(result: .result(messageViewModels, response.scrollIndexPath))
        view.displayMessages(viewModel: viewModel)
    }
    
    func presentSendMessage(response: Chat.SendMessage.Response) {
        view.displaySendMessage(viewModel: Chat.SendMessage.ViewModel(error: response.error))
    }
    
    func presentMessageUpdates(response: Chat.SubscribeMessageUpdates.Response) {
        guard
            let currentUserId = currentUser?.id,
            let currentUserName = currentUser?.fullName,
                response.error == nil else {
            let viewModel = Chat.SubscribeMessageUpdates.ViewModel(result: .error(CommonError(message: "Can't present message.")!))
            view.displayMessageUpdates(viewModel: viewModel)
            return
        }
        let messageViewModels = convert(message: response.newMessage,
                                        recipientUserName: response.recipientUserName,
                                        currentUserId: currentUserId,
                                        currentUserName: currentUserName)
        let viewModel = Chat.SubscribeMessageUpdates.ViewModel(result: .result(messageViewModels, response.scrollIndexPath))
        view.displayMessageUpdates(viewModel: viewModel)
    }
}
