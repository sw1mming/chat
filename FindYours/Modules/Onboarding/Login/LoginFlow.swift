//
//  LoginFlow.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/23/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

enum Login {
    
    enum LoginUser {
        struct Request {
            var email: String?
            var password: String?
        }
        
        struct Response {
            let error: CommonError?
        }
        
        struct ViewModel {
            let error: CommonError?
        }
    }
}
