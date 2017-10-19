//
//  CollectionExtension.swift
//  Perpetio-Test-Task
//
//  Created by Radio Shaolin on 19.09.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

// MARK: - Checking of element under index in collection
extension Collection {
    subscript(optional index: Index) -> Iterator.Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
    
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
