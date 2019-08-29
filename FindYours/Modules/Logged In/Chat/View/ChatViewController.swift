//
//  ChatViewController.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/7/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    let interactor: ChatInteractorProtocol
    
    var chatView: ChatView { return view as! ChatView }
    
    let tableDataSource = ChatTableDataSource()
    
    let titleText: String?
    
    deinit {
        print("!!! ChatViewController deinit !!!")
        NotificationCenter.default.removeObserver(self)
    }
    
    init(interactor: ChatInteractorProtocol, titleText: String?) {
        self.interactor = interactor
        self.titleText = titleText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() { setupView() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMessages()
        subscribeOnUpdates()
    }
    
    private func loadMessages() {
        startActivityIndicator()
        let request = Chat.LoadMessages.Request()
        interactor.loadMessages(request: request)
    }
    
    private func subscribeOnUpdates() {
        let subscribeRequest = Chat.SubscribeMessageUpdates.Request()
        interactor.subscribeOnMessageUpdates(request: subscribeRequest)
    }
    
    func scrollToBottom(at indexPath: IndexPath) {
        chatView.tableView.scrollToRow(at: indexPath,
                                       at: .none,
                                       animated: false)
    }
}

extension ChatViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        chatView.setEnableConfirmButton()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text != "\n" else { return false }
        return true
    }
}

extension ChatViewController: ChatViewProtocol {
    
    func displayMessages(viewModel: Chat.LoadMessages.ViewModel) {
        stopActivityIndicator()
        switch viewModel.result {
        case let .result(messages, scrollIndexPath):
            guard !messages.isEmpty else { return }
            tableDataSource.presentationModels = messages
            chatView.tableView.reloadData()
            scrollToBottom(at: scrollIndexPath)
        case let .error(error):
            let alert = UIAlertController(title: "Error !!!", message: error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        }
    }
    
    func displaySendMessage(viewModel: Chat.SendMessage.ViewModel) {
        if let error = viewModel.error {
            let alert = UIAlertController(title: "Error !!!", message: "Can't send message. \(error.message)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        }
    }
    
    func displayMessageUpdates(viewModel: Chat.SubscribeMessageUpdates.ViewModel) {
        stopStatusBarIndicator()
        
        switch viewModel.result {
        case let .result(message, scrollIndexPath):
            tableDataSource.presentationModels.append(message)
            UIView.performWithoutAnimation {
                chatView.tableView.insertRows(at: [scrollIndexPath], with: .none)
            }
            scrollToBottom(at: scrollIndexPath)
        case let .error(error):
            let alert = UIAlertController(title: "Error !!!", message: error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        }
    }
}

extension ChatViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        let bottomConstraint = chatView.constraints.filter({ $0.firstAttribute == .bottom }).first
        guard bottomConstraint?.constant == 0 else { return }
        
        bottomConstraint?.constant -= keyboardSize.height
        var contentOffset = chatView.tableView.contentOffset
        contentOffset.y += keyboardSize.height
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.chatView.layoutIfNeeded()
            if self.tableDataSource.presentationModels.count > self.chatView.tableView.visibleCells.count {
                self.chatView.tableView.setContentOffset(contentOffset, animated: true)                
            }
        })
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let bottomConstraint = chatView.constraints.filter({ $0.firstAttribute == .bottom }).first
        if bottomConstraint?.constant != 0 {
            bottomConstraint?.constant = 0
            chatView.layoutIfNeeded()
        }
    }
}
