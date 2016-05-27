//
//  Application.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 20/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit

class Application {
    //MARK: - Dependencies
    private let window: UIWindow
    lazy var navigation: Navigation = Navigation(
        window: self.window,
        navigationController: NavigationController(),
        application: self
    )
    lazy var network = NetworkProvider(session: NSURLSession.sharedSession())
    lazy var api: API = API(network: self.network)
    lazy var imageCache: ImageCache = ImageCacheProvider(network: self.network)
    
    //MARK: - Lifecycle
    init(window: UIWindow) {
        self.window = window
    }
}
