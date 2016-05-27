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
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.app = Application(window: window)
        
        self.window = window
        self.app?.navigation.start()
        return true
    }
}
