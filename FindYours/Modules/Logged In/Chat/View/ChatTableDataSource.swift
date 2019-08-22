//
//  ChatTableDataSource.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/18/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class ChatTableDataSource: NSObject {
    
    var presentationModels = [Chat.MessagePresentationModel]()
}

extension ChatTableDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentationModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = presentationModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.userNameLabel.text = message.userName
        cell.messageTextLabel.text = message.text
        cell.timeLabel.text = message.time
        
        return cell
    }
}

extension ChatTableDataSource: UITableViewDelegate { }
