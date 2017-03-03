//
//  FriendDetailViewController.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 22/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit

class FriendDetailViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet fileprivate var backingView: UIView!
    @IBOutlet fileprivate var friendImageView: RoundedImageView!
    @IBOutlet fileprivate var friendNameLabel: UILabel!
    @IBOutlet fileprivate var friendEmailLabel: UILabel!
    @IBOutlet fileprivate var friendAboutLabel: UITextView!
    
    //MARK: - Private
    fileprivate var viewModel: FriendDetailViewModel!
    
    //MARK: - Lifecycle
    convenience init(viewModel: FriendDetailViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color = UIColor.randomPastelColor()
        self.backingView.backgroundColor = color
        self.friendImageView.borderColor = color
        
        self.viewModelDidUpdate()
        self.bindToViewModel()
    }
    
    //MARK: - ViewModel
    fileprivate func bindToViewModel() {
        self.viewModel.didUpdate = { [weak self] in
            self?.viewModelDidUpdate()
        }
        self.viewModel.didError = { [weak self] error in
            self?.viewModelDidError(error)
        }
    }
    fileprivate func viewModelDidUpdate() {
        self.friendImageView.image = self.viewModel.image
        self.friendNameLabel.text = self.viewModel.fullName
        self.friendEmailLabel.text = self.viewModel.email
        self.friendAboutLabel.text = self.viewModel.about
    }
    fileprivate func viewModelDidError(_ error: Error) {
        UIAlertView(title: "Error", message: error.displayString(), delegate: nil, cancelButtonTitle: "OK").show()
    }
}

extension FriendDetailViewController: Themeable {
    var navigationBarBackgroundColor: UIColor? { return self.backingView?.backgroundColor }
    var navigationBarTintColor: UIColor? { return .white }
}
