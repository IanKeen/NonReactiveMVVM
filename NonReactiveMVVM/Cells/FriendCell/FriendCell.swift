//
//  FriendCell.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 21/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet fileprivate var friendNameLabel: UILabel!
    @IBOutlet fileprivate var friendImageView: UIImageView!
    
    //MARK: - Public
    func setup(_ viewModel: FriendCellViewModel) {
        guard viewModel.allowedAccess(self) else { return }
        
        self.friendNameLabel.text = viewModel.fullName
        self.friendImageView.image = viewModel.image ?? UIImage(named: "default")
        
        viewModel.didUpdate = self.setup
        
        viewModel.loadThumbnailImage()
    }
}
