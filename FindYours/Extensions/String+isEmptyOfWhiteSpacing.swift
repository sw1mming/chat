//
//  String+isEmptyOfWhiteSpacing.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/18/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import Foundation

extension String {
    func isEmptyOrWhitespace() -> Bool {
        guard !isEmpty else { return true }
        return trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
    }
}
