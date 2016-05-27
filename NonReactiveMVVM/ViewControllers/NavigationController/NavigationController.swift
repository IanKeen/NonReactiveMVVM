//
//  NavigationController.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 23/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit

protocol Themeable {
    var navigationBarBackgroundColor: UIColor? { get }
    var navigationBarTintColor: UIColor? { get }
}

class NavigationController: UINavigationController {
    //MARK: - Properties
    var defaultNavBarBackgroundColor: UIColor = .whiteColor()
    var defaultNavBarTintColor: UIColor = .blackColor()
    var hideBackButtonText: Bool = true
    
    //MARK: - Private
    private var backButtonTextCache = [UIViewController: String?]()
    
    //MARK: - Lifecycle
    required convenience init() {
        self.init(navigationBarClass: nil, toolbarClass: nil)
        self.navigationBar.shadowImage = UIImage()
    }
    
    //MARK: - Navigation
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        self.cacheTitleAndHide()
        let root = (self.viewControllers.count == 0)
        self.styleViewController(viewController, root: root)
        super.pushViewController(viewController, animated: animated)
    }
    override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
        let destinationVC = self.viewControllers.dropLast().last
        let root = (self.viewControllers.dropLast().count == 1)
        self.uncacheTitleAndShow(destinationVC)
        self.styleViewController(destinationVC, root: root)
        return super.popViewControllerAnimated(animated)
    }
    
    //MARK: - Styling
    private func styleViewController(vc: UIViewController?, root: Bool) {
        if let vc = vc as? Themeable {
            let backgroundColor = vc.navigationBarBackgroundColor ?? self.defaultNavBarBackgroundColor
            self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            
            if (root) {
                self.navigationBar.setBackgroundImage(
                    UIImage.fromColor(backgroundColor),
                    forBarMetrics: UIBarMetrics.Default
                )
            } else {
                self.navigationBar.barTintColor = backgroundColor
            }
            self.navigationBar.translucent = true
            
            self.navigationBar.tintColor = vc.navigationBarTintColor ?? self.defaultNavBarTintColor
        }
    }
    
    //MARK: - Back Button
    private func cacheTitleAndHide() {
        guard self.hideBackButtonText else { return }
        
        if let vc = self.viewControllers.last {
            self.backButtonTextCache[vc] = vc.title
            vc.title = ""
        }
    }
    private func uncacheTitleAndShow(vc: UIViewController?) {
        guard self.hideBackButtonText else { return }
        
        guard
            let vc = vc,
            let cachedTitle = self.backButtonTextCache[vc]
            else { return }

        vc.title = cachedTitle
        self.backButtonTextCache[vc] = nil
    }
}
