//
//  ChatProtocols.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/18/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

// MARK: - Business Logic Protocol
protocol ChatInteractorProtocol {
    func subscribeOnMessageUpdates(request: Chat.SubscribeMessageUpdates.Request)
    func loadMessages(request: Chat.LoadMessages.Request)
    func sendMessage(request: Chat.SendMessage.Request)
}

// MARK: - Presentation Protocol
protocol ChatPresenterProtocol {
    func presentMessages(response: Chat.LoadMessages.Response)
    func presentSendMessage(response: Chat.SendMessage.Response)
    func presentMessageUpdates(response: Chat.SubscribeMessageUpdates.Response)
}

// MARK: - View Protocol
protocol ChatViewProtocol: class {
    func displayMessages(viewModel: Chat.LoadMessages.ViewModel)
    func displaySendMessage(viewModel: Chat.SendMessage.ViewModel)
    func displayMessageUpdates(viewModel: Chat.SubscribeMessageUpdates.ViewModel)
}
