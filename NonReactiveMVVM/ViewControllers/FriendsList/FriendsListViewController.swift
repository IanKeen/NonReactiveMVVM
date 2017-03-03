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
    @IBOutlet fileprivate var tableView: UITableView!
    
    //MARK: - Private
    fileprivate var viewModel: FriendsListViewModel!
    
    //MARK: - Lifecycle
    required convenience init(viewModel: FriendsListViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.title
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Refresh", style: .plain,
            target: self, action: #selector(FriendsListViewController.reloadData)
        )
        self.viewModel.friendViewModelsTypes.forEach { $0.registerCell(self.tableView) }
        self.bindToViewModel()
        self.reloadData()
    }
    
    //MARK: - ViewModel
    fileprivate func bindToViewModel() {
        self.viewModel.didUpdate = { [weak self] _ in
            self?.viewModelDidUpdate()
        }
        self.viewModel.didError = { [weak self] error in
            self?.viewModelDidError(error)
        }
    }
    fileprivate func viewModelDidUpdate() {
        self.title = self.viewModel.title
        self.navigationItem.rightBarButtonItem?.isEnabled = !self.viewModel.isUpdating
        self.tableView.reloadData()
    }
    fileprivate func viewModelDidError(_ error: Error) {
        UIAlertView(title: "Error", message: error.displayString(), delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    //MARK: - Actions
    @objc fileprivate func reloadData() {
        self.viewModel.reloadData()
    }
}

extension FriendsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.friendViewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.friendViewModels[indexPath.row]
            .dequeueCell(tableView, indexPath: indexPath)
    }
}

extension FriendsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.friendViewModels[indexPath.row].cellSelected()
    }
}

extension FriendsListViewController: Themeable {
    var navigationBarBackgroundColor: UIColor? { return .white }
    var navigationBarTintColor: UIColor? { return .black }
}
