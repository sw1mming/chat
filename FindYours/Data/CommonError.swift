//
//  CommonError.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/9/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

struct CommonError: Error {
    var localizedDescription: String {
        return message
    }
    
    var message = ""
    
    init?(message: String?) {
        if let message = message {
            self.message = message 
        } else {
            return nil
        }
    }
}
