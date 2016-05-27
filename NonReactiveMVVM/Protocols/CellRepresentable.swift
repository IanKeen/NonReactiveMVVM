//
//  CellRepresentable.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 21/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit

protocol CellRepresentable {
    static func registerCell(tableView: UITableView)
    func dequeueCell(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell
    func cellSelected()
}
