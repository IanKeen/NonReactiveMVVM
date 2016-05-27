//
//  Friend.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 20/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import Foundation

struct Friend {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let image_small: String
    let image_large: String
    let about: String
}

extension Friend {
    init?(json: [String: AnyObject]) {
        
        guard
            let id = json.getWithKeyPath("id.value", as: String.self),
            let firstName = json.getWithKeyPath("name.first", as: String.self),
            let lastName = json.getWithKeyPath("name.last", as: String.self),
            let email = json.getWithKeyPath("email", as: String.self),
            let image_small = json.getWithKeyPath("picture.thumbnail", as: String.self),
            let image_large = json.getWithKeyPath("picture.large", as: String.self),
            let about = json.getWithKeyPath("about", as: String.self)
            else { return nil }
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.image_small = image_small
        self.image_large = image_large
        self.about = about
    }
}