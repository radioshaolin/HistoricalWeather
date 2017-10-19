//
//  MonthlyMeteoData.swift
//  Perpetio-Test-Task
//
//  Created by Radio Shaolin on 19.09.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

// MARK: - Month
/**
A simple enumeration representing a month in a year.
*/
enum Month : Int {
	case January = 1, February, March, April, May, June, July, August, September, October, November, December

	func displayName(locale: Locale = Locale.autoupdatingCurrent) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = "MMMM"
        return formatter.monthSymbols[self.rawValue - 1]
	}
}

// MARK: - Printable protocol
extension Month : CustomStringConvertible {
	var description: String {
		return self.displayName()
	}
}

// MARK: - DebugPrintable protocol
extension Month : CustomDebugStringConvertible {
	var debugDescription: String {
		return self.description
	}
}

// MARK: - Equatable, Comparable protocol
extension Month : Equatable, Comparable {

    static func ==(lhs: Month, rhs: Month) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }

    static func <(lhs: Month, rhs: Month) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}


