//
//  CellRepresentable.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 21/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit

protocol CellRepresentable {
    static func registerCell(_ tableView: UITableView)
    func dequeueCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func cellSelected()
}
