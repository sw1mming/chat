//
//  ChatsListViewController+TableViewDelegates.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/10/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

extension UsersListViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        
        // TODO: Update identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.userNameLabel.text = user.email
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = users[indexPath.row]
        navigationController?.pushViewController(ChatBuilder().build(user: user), animated: true)
    }
}
