//
//  NonReactiveMVVMTests.swift
//  NonReactiveMVVMTests
//
//  Created by Ian Keen on 27/05/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import XCTest
@testable import NonReactiveMVVM

class NonReactiveMVVMTests: XCTestCase {
    func testFriendCell_shouldDisplayCorrectFullName() {
        let friend = Friend(id: "", firstName: "Ian", lastName: "Keen", email: "", image_small: "", image_large: "", about: "")
        let viewModel = FriendCellViewModel(friend: friend, imageCache: MockImageCache())
        XCTAssertEqual(viewModel.fullName, "Ian Keen")
    }
}
