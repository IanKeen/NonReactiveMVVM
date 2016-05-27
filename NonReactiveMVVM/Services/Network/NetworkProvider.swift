//
//  NetworkProvider.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 20/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import Foundation

class NetworkProvider: Network {
    //MARK: - Private
    let session: NSURLSession
    
    //MARK: - Lifecycle
    init(session: NSURLSession = NSURLSession.sharedSession()) {
        self.session = session
        
    }
    
    //MARK: - Public
    func makeRequest(request: NetworkRequest, success: ([String : AnyObject]) -> Void, failure: (ErrorType) -> Void) -> NetworkCancelable? {
        do {
            let request = try request.buildURLRequest()
            let task = self.session.dataTaskWithRequest(request) { (data, response, error) in
                guard let data = data else {
                    dispatch_async(dispatch_get_main_queue()) { failure(error ?? NetworkError.Unknown) }
                    return
                }
                
                guard
                    let jsonOptional = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
                    let json = jsonOptional as? [String: AnyObject]
                    else {
                        dispatch_async(dispatch_get_main_queue()) { failure(NetworkError.InvalidResponse) }
                        return
                    }
                dispatch_async(dispatch_get_main_queue()) { success(json) }
            }
            task.resume()
            return task
            
        } catch let error {
            failure(error)
            return nil
        }
    }
    func makeRequest(request: NetworkRequest, success: (NSData) -> Void, failure: (ErrorType) -> Void) -> NetworkCancelable? {
        do {
            let request = try request.buildURLRequest()
            let task = self.session.dataTaskWithRequest(request) { (data, response, error) in
                guard let data = data else {
                    dispatch_async(dispatch_get_main_queue()) { failure(error ?? NetworkError.Unknown) }
                    return
                }
                dispatch_async(dispatch_get_main_queue()) { success(data) }
            }
            task.resume()
            return task
            
        } catch let error {
            failure(error)
            return nil
        }
    }
}
