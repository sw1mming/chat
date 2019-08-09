//
//  UIViewController+ActivityIndicator.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/6/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController {
    
    func startActivityIndicator() {
        let data = ActivityData(size: CGSize(width: 50, height: 50),
                                message: nil,
                                messageFont: nil,
                                messageSpacing: 0,
                                type: .pacman,
                                color: .purple,
                                padding: 0,
                                displayTimeThreshold: nil,
                                minimumDisplayTime: nil,
                                backgroundColor: nil,
                                textColor: .blue)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(data)
    }
    
    func stopActivityIndicator() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
