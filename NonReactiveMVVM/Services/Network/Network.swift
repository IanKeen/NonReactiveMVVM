//
//  Network.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 20/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case unknown
    case invalidResponse
    
    var description: String {
        switch self {
        case .unknown: return "An unknown error occurred"
        case .invalidResponse: return "Received an invalid response"
        }
    }
}

protocol NetworkCancelable {
    func cancel()
}
extension URLSessionDataTask: NetworkCancelable { }

protocol Network {
    func makeRequest(_ request: NetworkRequest, success: @escaping ([String: AnyObject]) -> Void, failure: @escaping (Error) -> Void) -> NetworkCancelable?
    func makeRequest(_ request: NetworkRequest, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) -> NetworkCancelable?
}
