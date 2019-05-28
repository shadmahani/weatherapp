//
//  Foundation + extension.swift
//  weather app
//
//  Created by hossein shademany on 5/28/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import Foundation

extension Array where Element:Equatable {
    
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
