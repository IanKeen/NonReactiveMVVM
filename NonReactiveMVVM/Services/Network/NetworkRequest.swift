//
//  NetworkRequest.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 20/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import Foundation

enum NetworkRequestError: Error, CustomStringConvertible {
    case invalidURL(String)
    
    var description: String {
        switch self {
        case .invalidURL(let url): return "The url '\(url)' was invalid"
        }
    }
}

struct NetworkRequest {
    //MARK: - HTTP Methods
    enum Method: String {
        case GET        = "GET"
        case PUT        = "PUT"
        case PATCH      = "PATCH"
        case POST       = "POST"
        case DELETE     = "DELETE"
    }
    
    //MARK: - Public Properties
    let method: NetworkRequest.Method
    let url: String
    
    //MARK: - Public Functions
    func buildURLRequest() throws -> URLRequest {
        guard let url = URL(string: self.url) else { throw NetworkRequestError.invalidURL(self.url) }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = self.method.rawValue
        
        return request as URLRequest
    }
}
