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
    @IBOutlet private var friendNameLabel: UILabel!
    @IBOutlet private var friendImageView: UIImageView!
    
    //MARK: - Public
    func setup(viewModel: FriendCellViewModel) {
        self.friendNameLabel.text = viewModel.fullName
        self.friendImageView.image = viewModel.image ?? UIImage(named: "default")
        
        viewModel.didUpdate = self.setup
        
        viewModel.loadThumbnailImage()
    }
}
