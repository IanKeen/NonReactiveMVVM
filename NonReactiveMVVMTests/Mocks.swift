//
//  Mocks.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 27/05/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit
@testable import NonReactiveMVVM

//The mocks here are not required for the test so we only need them to satisfy the compiler
class MockNetwork: Network {
    func makeRequest(request: NetworkRequest, success: ([String: AnyObject]) -> Void, failure: (ErrorType) -> Void) -> NetworkCancelable? { return nil }
    func makeRequest(request: NetworkRequest, success: (NSData) -> Void, failure: (ErrorType) -> Void) -> NetworkCancelable? { return nil }
}
class MockImageCache: ImageCache {
    convenience init() { self.init(network: MockNetwork()) }
    required init(network: Network) { }
    func image(url url: String, success: (UIImage) -> Void, failure: (ErrorType) -> Void) -> NetworkCancelable? { return nil }
    func hasImageFor(url: String) -> Bool { return false }
    func cachedImage(url url: String, or: UIImage?) -> UIImage? { return nil }
    func clearCache() { }
}
