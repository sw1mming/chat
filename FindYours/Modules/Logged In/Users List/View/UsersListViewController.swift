//
//  ListChatViewController.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/4/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class UsersListViewController: UITableViewController {
    
    var users = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(ofType: UserCell.self)
        tableView.tableFooterView = UIView()
        
        startActivityIndicator()
        DatabaseManager.instance.getAllUsers { [weak self] users in
            self?.users = users
            self?.users.removeAll(where: { user -> Bool in
                user.id == AccountController.instance.currentUser?.id
            })
            self?.tableView.reloadData()
            self?.stopActivityIndicator()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
    }
    
    @objc func logout() {
        DatabaseManager.instance.logout { isCompleted in
            if isCompleted {
                appDelegate.window?.rootViewController = LoginBuilder().build()
            }
        }
    }
}
