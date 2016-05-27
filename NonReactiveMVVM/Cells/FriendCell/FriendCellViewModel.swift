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
    private let friend: Friend
    private let imageCache: ImageCache
    private var imageCacheCancellable: NetworkCancelable?
    
    //MARK: - Lifecycle
    init(friend: Friend, imageCache: ImageCache) {
        self.friend = friend
        self.imageCache = imageCache
    }
    deinit {
        self.imageCacheCancellable?.cancel()
    }
    
    //MARK: - Events
    var didError: ((ErrorType) -> Void)?
    var didUpdate: ((FriendCellViewModel) -> Void)?
    var didSelectFriend: ((Friend) -> Void)?
    
    //MARK: - Properties
    var fullName: String { return "\(self.friend.firstName.capitalizedString) \(self.friend.lastName.capitalizedString)" }
    private(set) var image: UIImage?
    
    //MARK: - Actions
    func loadThumbnailImage() {
        guard self.image == nil else { return } //ignore if we already have an image
        guard self.imageCacheCancellable == nil else { return } //ignore if we are already fetching
        
        self.imageCacheCancellable = self.imageCache.image(
            url: self.friend.image_small,
            success: { image in
                self.image = image
                self.didUpdate?(self)
            },
            failure: { error in
                self.didError?(error)
            }
        )
    }
}

extension FriendCellViewModel: CellRepresentable {
    static func registerCell(tableView: UITableView) {
        tableView.registerNib(UINib(nibName: String(FriendCell), bundle: nil), forCellReuseIdentifier: String(FriendCell))
    }
    func dequeueCell(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(FriendCell), forIndexPath: indexPath) as! FriendCell
        cell.setup(self)
        return cell
    }
    func cellSelected() {
        self.didSelectFriend?(self.friend)
    }
}
