//
//  AppDelegate.swift
//  HZXSwiftToolManager
//
//  Created by 侯仲祥 on 2020/6/30.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var tabbarController =  DDCustomTabBarController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window?.rootViewController = tabbarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

