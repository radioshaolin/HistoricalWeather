//
//  SequenceExtension.swift
//  Perpetio-Test-Task
//
//  Created by Radio Shaolin on 18.09.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

// MARK: - Method display unique elements of array
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var alreadyAdded = Set<Iterator.Element>()
        return self.filter { alreadyAdded.insert($0).inserted }
    }
}
