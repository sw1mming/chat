//
//  Dictionary+JsonToData.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/22/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func toData() -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self,
                                              options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            print("Can't parse json to data. Error: \(error.localizedDescription)")
            return nil
        }
    }
}
