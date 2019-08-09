//
//  AppDelegate.swift
//  FindYours
//
//  Created by Melnik Sergey on 7/3/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit
import Firebase

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = Auth.auth().currentUser == nil ? LoginBuilder().build() : TabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

// TODO:
// 1. save current user in to AccountController
