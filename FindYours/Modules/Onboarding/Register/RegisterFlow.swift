//
//  RegisterFlow.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/31/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

enum Register {
    
    enum RegisterUser {
        struct Request {
            let fullName: String?
            let email: String?
            let password: String?
        }
        
        struct Response {
            let error: CommonError?
        }
        
        struct ViewModel {
            let error: CommonError?
        }
    }
    
    enum ChooseAvatar {
        struct Request {
            let image: UIImage?
        }
        
        struct Response {
            let error: CommonError?
        }
        
        struct ViewModel {
            let error: CommonError?
        }
    }
}
