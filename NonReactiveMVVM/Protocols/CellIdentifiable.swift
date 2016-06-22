//
//  CellIdentifiable.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 21/06/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import ObjectiveC
import UIKit

protocol CellIdentifiable: class {
    var uniqueId: NSIndexPath? { get set }
}

private struct AssociatedKeys {
    static var UniqueID = "UniqueID"
}

extension UITableViewCell: CellIdentifiable {
    var uniqueId: NSIndexPath? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.UniqueID) as? NSIndexPath }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.UniqueID, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.UniqueID, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

}
