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
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(ofType: ChatCell.self)
//        tableView.register(ChatCell.self, forCellReuseIdentifier: "ChatCell")
//        let identifier = String(describing: ChatCell.self)
//        var bundle: Bundle? = nil
//
////        if let bundleName = identifier {
//            bundle = Bundle(for: ChatCell.self)
////        }
//
//        tableView.register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
        
        DatabaseManager.instance.getAllUsers { [weak self] users in
            self?.users = users
            self?.tableView.reloadData()
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

extension UITableView {
    
    func registerCell<T: UITableViewCell>(ofType type: T.Type) {
        let cellName = String(describing: T.self)
        
        if Bundle.main.path(forResource: cellName, ofType: "nib") != nil {
            let nib = UINib(nibName: cellName, bundle: Bundle.main)
            
            register(nib, forCellReuseIdentifier: cellName)
        } else {
            register(T.self, forCellReuseIdentifier: cellName)
        }
    }
}
