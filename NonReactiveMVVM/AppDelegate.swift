//
//  AppDelegate.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 14/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var app: Application?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.app = Application(window: window)
        
        self.window = window
        self.app?.navigation.start()
        return true
    }
}
