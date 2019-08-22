//
//  ChatBuilder.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/13/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class ChatBuilder {
    
    func build(user: UserModel) -> UIViewController {
        let presenter = ChatPresenter()
        let interactor = ChatInteractor(presenter: presenter, recipientUser: user)
        let view = ChatViewController(interactor: interactor, titleText: user.fullName ?? "")
        presenter.set(view)
        
        view.hidesBottomBarWhenPushed = true
        return view
    }
}
