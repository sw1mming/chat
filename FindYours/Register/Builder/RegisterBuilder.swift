//
//  RegisterBuilder.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/31/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class RegisterBuilder {
    
    func build() -> UIViewController {
//        let presenter = RegisterPresenter()
//        let interactor = RegisterInteractor(presenter: presenter)
        let view = RegisterViewController()//(interactor: interactor)
//        presenter.set(view)
        
        return view
    }
}
