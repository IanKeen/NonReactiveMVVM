//
//  SequenceType+Extensions.swift
//  NonReactiveMVVM
//
//  Created by Ian Keen on 20/04/2016.
//  Copyright © 2016 Mustard. All rights reserved.
//

import Foundation

func random(min: Int, max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max + 1)) + UInt32(min))
}

extension Array {
    var randomElement: Element {
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
}
//extension Collection  {
//    func randomElement() -> Self.Iterator.Element {
//        let index = random(min: 0, max: Int(self.count) - 1)
//        return self[index]
//    }
//    subscript(safe safe: Self.Index) -> Iterator.Element? {
//        guard self.indices.contains(where: safe) else { return nil }
//        return self[safe]
//    }
//}
