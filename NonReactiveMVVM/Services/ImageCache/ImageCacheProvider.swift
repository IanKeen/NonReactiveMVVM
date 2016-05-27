//
//  ImageCacheProvider.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 27/05/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import UIKit

class ImageCacheProvider: ImageCache {
    //MARK: - Private
    private var cache = [String: UIImage]()
    private let network: Network
    
    //MARK: - Lifecycle
    required init(network: Network) {
        self.network = network
    }
    
    //MARK: - Public
    func image(url url: String, success: (UIImage) -> Void, failure: (ErrorType) -> Void) -> NetworkCancelable? {
        if let existing = self.cache[url] {
            success(existing)
            print("cached")
            return nil
        }
        
        let request = NetworkRequest(method: .GET, url: url)
        return self.network.makeRequest(
            request,
            success: { [weak self] (data: NSData) in
                guard let `self` = self else { return }
                
                guard let image = UIImage(data: data) else {
                    failure(ImageCacheError.InvalidResponse)
                    return
                }
                self.cache[url] = image
                success(image)
            },
            failure: failure)
    }
    func hasImageFor(url: String) -> Bool {
        return (self.cache[url] != nil)
    }
    func cachedImage(url url: String, or: UIImage?) -> UIImage? {
        return self.cache[url] ?? or
    }
    func clearCache() { self.cache = [String: UIImage]() }
}
