//
//  NetworkRequest.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 20/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import Foundation

enum NetworkRequestError: ErrorType, CustomStringConvertible {
    case InvalidURL(String)
    
    var description: String {
        switch self {
        case .InvalidURL(let url): return "The url '\(url)' was invalid"
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
    func buildURLRequest() throws -> NSURLRequest {
        guard let url = NSURL(string: self.url) else { throw NetworkRequestError.InvalidURL(self.url) }
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = self.method.rawValue
        
        return request
    }
}
