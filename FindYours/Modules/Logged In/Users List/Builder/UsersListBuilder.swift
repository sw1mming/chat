//
//  ChatsListBuilder.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/6/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class UsersListBuilder {
    
    func build() -> UIViewController {
        let view = UsersListViewController()
        
        return UINavigationController(rootViewController: view)
    }
}
