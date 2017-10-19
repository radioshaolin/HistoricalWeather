//
//  Parser.swift
//  Perpetio-Test-Task
//
//  Created by Radio Shaolin on 20.09.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

// MARK: - NetworkingService
/**
 Singleton class responsible for async fetching data with given url
 */
class Parser {
    static let instance = Parser()
    private init() {}
    
    class func parse(textData: String) throws -> [[String]] {
            // Splitting raw string in to array by "\r\n"
            let splittedTextData = textData.split(separator: "\r\n")
            
            // Defining startIndex where data is started
            var startIndex = 0
            if let index = splittedTextData.index(of: "              degC    degC    days      mm   hours") { startIndex  = index + 1 }
            
            // Creating of monthly data arrays in needed range
            var rawMonthlyDataArrays = splittedTextData[startIndex..<splittedTextData.count].map { $0.split(separator: " ") }
//            print(rawMonthlyDataArrays)
            // Removing unnecessery "Provisional" element from some arrays
            rawMonthlyDataArrays = rawMonthlyDataArrays.flatMap { $0.filter { $0 != "Provisional" } }
            
        // Clearing elements of array by deleting "*" and "#" characters existing in some elements
        var clearMonthlyDataArrays = rawMonthlyDataArrays.map { $0.map { $0.replacingOccurrences(of: "*", with: "") } }
        
        clearMonthlyDataArrays = rawMonthlyDataArrays.map { $0.map { $0.replacingOccurrences(of: "#", with: "") } }
 
         return clearMonthlyDataArrays
    }
}

