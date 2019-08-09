//
//  ChatViewController.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/7/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    let recipientUser: UserModel
    
    var chatView: ChatView {
        return view as! ChatView
    }
    
    var messages = [MessageModel]()
    
    init(recipientUser: UserModel) {
        self.recipientUser = recipientUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ChatView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatView.tableView.dataSource = self
        chatView.tableView.delegate = self
        chatView.tableView.estimatedRowHeight = UITableView.automaticDimension
        chatView.tableView.rowHeight = UITableView.automaticDimension
        chatView.tableView.registerCell(ofType: ChatCell.self)
        
        let message = MessageModel(text: "Hello3", id: "bla", ownerId: "blabla", recipientId: recipientUser.id)
    
        DatabaseManager.instance.loadAllMessagesFor(userId: recipientUser.id!) { [weak self] messages in
            self?.messages = messages
            self?.chatView.tableView.reloadData()
        }
        
        DatabaseManager.instance.subscribeMessagesUpdatesFor(userId: message.recipientId!) { [weak self] msg in
            if let message = msg {
                self?.messages.append(message)
                self?.chatView.tableView.reloadData()
            }
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(send))
    }
    
    @objc func send() {
        let message = MessageModel(text: "Hello3", id: "bla", ownerId: "blabla", recipientId: recipientUser.id)
        DatabaseManager.instance.send(message: message)
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.messageTextLabel.text = message.text
        
        return cell
    }
}
