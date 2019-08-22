//
//  Data+toJson.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/22/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

extension Data {
    
    func toJSON() -> [String : Any]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [String : Any]
        } catch {
            print("Can't parse data to json. Error: \(error.localizedDescription)")
            return nil
        }
    }
}
