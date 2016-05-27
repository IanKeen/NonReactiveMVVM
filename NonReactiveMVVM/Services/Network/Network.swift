//
//  Network.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 20/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import Foundation

enum NetworkError: ErrorType, CustomStringConvertible {
    case Unknown
    case InvalidResponse
    
    var description: String {
        switch self {
        case .Unknown: return "An unknown error occurred"
        case .InvalidResponse: return "Received an invalid response"
        }
    }
}

protocol NetworkCancelable {
    func cancel()
}
extension NSURLSessionDataTask: NetworkCancelable { }

protocol Network {
    func makeRequest(request: NetworkRequest, success: ([String: AnyObject]) -> Void, failure: (ErrorType) -> Void) -> NetworkCancelable?
    func makeRequest(request: NetworkRequest, success: (NSData) -> Void, failure: (ErrorType) -> Void) -> NetworkCancelable?
}
