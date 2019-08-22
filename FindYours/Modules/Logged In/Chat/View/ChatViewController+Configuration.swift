//
//  ChatViewController+Configuration.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/14/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

extension ChatViewController {
    
    func setupView() {
        view = ChatView()
        setupTableView()
        setupActions()
        title = titleText
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupTableView() {
        chatView.tableView.tableFooterView = UIView()
        chatView.tableView.registerCell(ofType: ChatCell.self)
    }
    
    private func setupActions() {
        chatView.tableView.delegate = tableDataSource
        chatView.tableView.dataSource = tableDataSource
        
        chatView.inputTextView.delegate = self
        chatView.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        chatView.setEnableConfirmButton()
    }
    
    @objc private func didTapConfirmButton() {
        startStatusBarIndicator()
        let request = Chat.SendMessage.Request(messageText: chatView.inputTextView.text)
        chatView.clearTextView()
        interactor.sendMessage(request: request)
    }
}
