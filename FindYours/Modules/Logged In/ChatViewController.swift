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
        let message = MessageModel(text: "Hello3", id: "bla", ownerId: "blabla", recipientId: recipientUser.id)
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(send))
        
        DatabaseManager.instance.loadAllMessagesFor(userId: recipientUser.id!) { messages in
            
        }
    }
    
    @objc func send() {
        let message = MessageModel(text: "Hello3", id: "bla", ownerId: "blabla", recipientId: recipientUser.id)
        DatabaseManager.instance.send(message: message)
    }
}
