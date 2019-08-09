//
//  RegisterFlow.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/31/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

enum Register {
    
    enum RegisterUser {
        struct Request {
            var fullName: String?
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
