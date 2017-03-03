//
//  FriendCellViewModel.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 21/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit

class FriendCellViewModel {
    //MARK: - Private
    fileprivate let friend: Friend
    fileprivate let imageCache: ImageCache
    fileprivate var imageCacheCancellable: NetworkCancelable?
    fileprivate var restrictedTo: IndexPath?
    
    //MARK: - Lifecycle
    init(friend: Friend, imageCache: ImageCache) {
        self.friend = friend
        self.imageCache = imageCache
    }
    deinit {
        self.imageCacheCancellable?.cancel()
    }
    
    //MARK: - Events
    var didError: ((Error) -> Void)?
    var didUpdate: ((FriendCellViewModel) -> Void)?
    var didSelectFriend: ((Friend) -> Void)?
    
    //MARK: - Properties
    var fullName: String { return "\(self.friend.firstName.capitalized) \(self.friend.lastName.capitalized)" }
    fileprivate(set) var image: UIImage?
    
    //MARK: - Actions
    func allowedAccess(_ object: CellIdentifiable) -> Bool {
        guard
            let restrictedTo = self.restrictedTo,
            let uniqueId = object.uniqueId
            else { return true }
        
        return uniqueId as IndexPath == restrictedTo
    }
    func loadThumbnailImage() {
        guard self.image == nil else { return } //ignore if we already have an image
        guard self.imageCacheCancellable == nil else { return } //ignore if we are already fetching
        
        self.imageCacheCancellable = self.imageCache.image(
            url: self.friend.image_small,
            success: { [weak self] image in
                guard let `self` = self else { return }
                
                self.image = image
                self.didUpdate?(self)
            },
            failure: { [weak self] error in
                self?.didError?(error)
            }
        )
    }
}

extension FriendCellViewModel: CellRepresentable {
    static func registerCell(_ tableView: UITableView) {
        tableView.register(UINib(nibName: String(describing: FriendCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FriendCell.self))
    }
    func dequeueCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FriendCell.self), for: indexPath) as! FriendCell
        cell.uniqueId = indexPath
        self.restrictedTo = indexPath
        cell.setup(self)
        return cell
    }
    func cellSelected() {
        self.didSelectFriend?(self.friend)
    }
}
