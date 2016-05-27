//
//  FriendsListViewModel.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 21/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import Foundation

class FriendsListViewModel {
    //MARK: - Private
    private let api: API
    private let imageCache: ImageCache
    
    //MARK: - Lifeycle
    init(api: API, imageCache: ImageCache) {
        self.api = api
        self.imageCache = imageCache
    }
    
    //MARK: - Events
    var didError: ((ErrorType) -> Void)?
    var didUpdate: ((FriendsListViewModel) -> Void)?
    var didSelectFriend: ((Friend) -> Void)?
    
    //MARK: - Properties
    let friendViewModelsTypes: [CellRepresentable.Type] = [FriendCellViewModel.self]
    private(set) var friendViewModels = [CellRepresentable]()
    var title: String {
        if (self.isUpdating) {
            return "Refreshing..."
        } else {
            return "Your Friends (\(self.friendViewModels.count))"
        }
    }
    private(set) var isUpdating: Bool = false {
        didSet { self.didUpdate?(self) }
    }
    
    //MARK: - Actions
    func reloadData() {
        self.isUpdating = true
        
        self.api.getFriends(
            success: { [weak self] friends in
                guard let `self` = self else { return }
                
                self.friendViewModels = friends.map { self.viewModelFor($0) }
                self.isUpdating = false
            },
            failure: { [weak self] error in
                guard let `self` = self else { return }
                
                self.didError?(error)
                self.isUpdating = false
            }
        )
    }
    
    //MARK: - Helpers
    private func viewModelFor(friend: Friend) -> CellRepresentable {
        let viewModel = FriendCellViewModel(friend: friend, imageCache: self.imageCache)
        viewModel.didSelectFriend = { [weak self] friend in
            self?.didSelectFriend?(friend)
        }
        viewModel.didError = { [weak self] error in
            self?.didError?(error)
        }
        return viewModel
    }
}