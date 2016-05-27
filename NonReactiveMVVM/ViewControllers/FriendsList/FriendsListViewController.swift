//
//  FriendsListViewController.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 21/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit

class FriendsListViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    //MARK: - Private
    private var viewModel: FriendsListViewModel!
    
    //MARK: - Lifecycle
    required convenience init(viewModel: FriendsListViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.title
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Refresh", style: .Plain,
            target: self, action: #selector(FriendsListViewController.reloadData)
        )
        self.viewModel.friendViewModelsTypes.forEach { $0.registerCell(self.tableView) }
        self.bindToViewModel()
        self.reloadData()
    }
    
    //MARK: - ViewModel
    private func bindToViewModel() {
        self.viewModel.didUpdate = { [weak self] _ in
            self?.viewModelDidUpdate()
        }
        self.viewModel.didError = { [weak self] error in
            self?.viewModelDidError(error)
        }
    }
    private func viewModelDidUpdate() {
        self.title = self.viewModel.title
        self.navigationItem.rightBarButtonItem?.enabled = !self.viewModel.isUpdating
        self.tableView.reloadData()
    }
    private func viewModelDidError(error: ErrorType) {
        UIAlertView(title: "Error", message: error.displayString(), delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    //MARK: - Actions
    @objc private func reloadData() {
        self.viewModel.reloadData()
    }
}

extension FriendsListViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.friendViewModels.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.viewModel.friendViewModels[indexPath.row]
            .dequeueCell(tableView, indexPath: indexPath)
    }
}

extension FriendsListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.viewModel.friendViewModels[indexPath.row].cellSelected()
    }
}

extension FriendsListViewController: Themeable {
    var navigationBarBackgroundColor: UIColor? { return .whiteColor() }
    var navigationBarTintColor: UIColor? { return .blackColor() }
}
