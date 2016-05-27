//
//  Dictionary+Extensions.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 20/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import Foundation

extension Dictionary where Key: StringLiteralConvertible {
    func getWithKeyPath<T>(keyPath: String, as: T.Type) -> T? {
        return self.getWithKeyPath(keyPath)
    }
    func getWithKeyPath<T>(keyPath: String) -> T? {
        var keyPath = keyPath
        let isKeyPath = keyPath.rangeOfString(".") != nil
        var dictionary = self
        if (isKeyPath) {
            let components = keyPath.componentsSeparatedByString(".")
            for i in 0..<components.count {
                let keyPathComponent = components[i]
                let isLast = (i == components.count - 1)
                if (isLast) {
                    keyPath = keyPathComponent
                } else if let nestedDictionary = dictionary[keyPathComponent as! Key] as? Dictionary {
                    dictionary = nestedDictionary
                } else {
                    return nil
                }
            }
        }
        
        guard let value = dictionary[keyPath as! Key] as? T else { return nil }
        return value
    }
    
    func append(other: [Key: Value]) -> [Key: Value] {
        var result = [Key: Value]()
        [self, other].forEach { dict in
            dict.forEach { key, value in
                if
                    let currentValue = result[key] as? [Key: Value],
                    let incomingValue = value as? [Key: Value],
                    let newValue = currentValue.append(incomingValue) as? Value {
                    result[key] = newValue
                    
                } else {
                    result[key] = value
                }
            }
        }
        return result

    }
}
