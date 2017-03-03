//
//  ImageCache.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 21/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit

enum ImageCacheError: Error, CustomStringConvertible {
    case InvalidResponse
    
    var description: String {
        switch self {
        case .InvalidResponse: return "Received an invalid response"
        }
    }
}

protocol ImageCache {
    init(network: Network)
    
    func image(url url: String, success: @escaping (UIImage) -> Void, failure: @escaping (Error) -> Void) -> NetworkCancelable?
    func hasImageFor(url: String) -> Bool
    func cachedImage(url url: String, or: UIImage?) -> UIImage?
    func clearCache()
}
