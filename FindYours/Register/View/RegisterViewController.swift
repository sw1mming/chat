//
//  RegisterViewController.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/31/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var registerView: RegisterView {
        return view as! RegisterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() { setupView() }
}
