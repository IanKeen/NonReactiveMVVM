//
//  Navigation.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 20/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit

class Navigation {
    //MARK: - Private
    fileprivate let navigationController: UINavigationController
    fileprivate let application: Application
    
    //MARK: - Lifecycle
    init(window: UIWindow, navigationController: UINavigationController, application: Application) {
        self.application = application
        self.navigationController = navigationController
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
    
    //MARK: - Public
    func start() {
        self.showFriendList()
    }
    
    //MARK: - Private
    fileprivate func showFriendList() {
        let viewModel = FriendsListViewModel(
            api: self.application.api,
            imageCache: self.application.imageCache
        )
        viewModel.didSelectFriend = { [weak self] friend in
            self?.showFriend(friend)
        }
        
        let instance = FriendsListViewController(viewModel: viewModel)
        self.navigationController.pushViewController(instance, animated: false)
    }
    fileprivate func showFriend(_ friend: Friend) {
        let viewModel = FriendDetailViewModel(
            friend: friend,
            imageCache: self.application.imageCache
        )
        let instance = FriendDetailViewController(viewModel: viewModel)
        self.navigationController.pushViewController(instance, animated: true)
    }
}
