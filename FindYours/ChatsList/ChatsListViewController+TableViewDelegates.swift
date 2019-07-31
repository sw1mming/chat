//
//  ChatsListViewController+TableViewDelegates.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/10/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

extension ChatsListViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }    
}
