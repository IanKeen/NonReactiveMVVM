//
//  FriendDetailViewModel.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 22/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit

class FriendDetailViewModel {
    //MARK: - Private
    private let friend: Friend
    private let imageCache: ImageCache
    private var imageCacheCancellable: NetworkCancelable?
    
    //MARK: - Lifecycle
    init(friend: Friend, imageCache: ImageCache) {
        self.friend = friend
        self.imageCache = imageCache
        self.loadLargeImage()
    }
    deinit {
        self.imageCacheCancellable?.cancel()
    }
    
    //MARK: - Events
    var didError: ((ErrorType) -> Void)?
    var didUpdate: (() -> Void)?
    
    //MARK: - Properties
    var fullName: String { return "\(self.friend.firstName.capitalizedString) \(self.friend.lastName.capitalizedString)" }
    private(set) lazy var image: UIImage? = self.imageCache.cachedImage(
        url: self.friend.image_large,
        or: self.imageCache.cachedImage(
            url: self.friend.image_small,
            or: UIImage(named: "default")
        )
    )
    var email: String { return self.friend.email }
    var about: String { return self.friend.about.capitalizedString }
    
    //MARK: - Actions
    private func loadLargeImage() {
        if (self.imageCache.hasImageFor(self.friend.image_large)) { return }
        
        self.imageCacheCancellable = self.imageCache.image(
            url: self.friend.image_large,
            success: { image in
                self.image = image
                self.didUpdate?()
            },
            failure: { error in
                self.didError?(error)
            }
        )
    }
}