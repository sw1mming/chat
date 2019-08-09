//
//  TabbarViewController.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/6/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chatItem = UITabBarItem()
        chatItem.title = "Chat"
        
        let chat = UsersListBuilder().build()
        chat.tabBarItem = chatItem
        setViewControllers([chat], animated: true)
        selectedIndex = 0
    }
}
