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
    var defaultNavBarBackgroundColor: UIColor = .white
    var defaultNavBarTintColor: UIColor = .black
    var hideBackButtonText: Bool = true
    
    //MARK: - Private
    fileprivate var backButtonTextCache = [UIViewController: String?]()
    
    //MARK: - Lifecycle
    required convenience init() {
        self.init(navigationBarClass: nil, toolbarClass: nil)
        self.navigationBar.shadowImage = UIImage()
    }
    
    //MARK: - Navigation
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.cacheTitleAndHide()
        let root = (self.viewControllers.count == 0)
        self.styleViewController(viewController, root: root)
        super.pushViewController(viewController, animated: animated)
    }
    override func popViewController(animated: Bool) -> UIViewController? {
        let destinationVC = self.viewControllers.dropLast().last
        let root = (self.viewControllers.dropLast().count == 1)
        self.uncacheTitleAndShow(destinationVC)
        self.styleViewController(destinationVC, root: root)
        return super.popViewController(animated: animated)
    }
    
    //MARK: - Styling
    fileprivate func styleViewController(_ vc: UIViewController?, root: Bool) {
        if let vc = vc as? Themeable {
            let backgroundColor = vc.navigationBarBackgroundColor ?? self.defaultNavBarBackgroundColor
            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            
            if (root) {
                self.navigationBar.setBackgroundImage(
                    UIImage.fromColor(backgroundColor),
                    for: UIBarMetrics.default
                )
            } else {
                self.navigationBar.barTintColor = backgroundColor
            }
            self.navigationBar.isTranslucent = true
            
            self.navigationBar.tintColor = vc.navigationBarTintColor ?? self.defaultNavBarTintColor
        }
    }
    
    //MARK: - Back Button
    fileprivate func cacheTitleAndHide() {
        guard self.hideBackButtonText else { return }
        
        if let vc = self.viewControllers.last {
            self.backButtonTextCache[vc] = vc.title
            vc.title = ""
        }
    }
    fileprivate func uncacheTitleAndShow(_ vc: UIViewController?) {
        guard self.hideBackButtonText else { return }
        
        guard
            let vc = vc,
            let cachedTitle = self.backButtonTextCache[vc]
            else { return }

        vc.title = cachedTitle
        self.backButtonTextCache[vc] = nil
    }
}
