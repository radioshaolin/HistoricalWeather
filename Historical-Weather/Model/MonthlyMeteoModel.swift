//
//  MonthlyMeteoModel.swift
//  Perpetio-Test-Task
//
//  Created by Radio Shaolin on 21.09.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

enum ValidationError: Error {
    case invalidYearNumber
    case invalidMonthNumber
    case nilFound
}

// MARK: - MonthlyMeteoModel
/**
 This class is a model of MonthlyMeteoData.
 */
class MonthlyMeteoModel {
    

    private(set) var meteoData: [MonthlyMeteoData] = []
    
    func getMeteoData(completion: @escaping ([MonthlyMeteoData]) -> Void) {
        NetworkingService.instance.downloadData(withURL: API.meteoDataRequestURL) { [weak self] parsedTextData in
            guard let strongSelf = self else { return }
            
            let meteoData = self?.getMeteoDataModel(parsedTextData: parsedTextData)
            guard let monthlyMeteoData = meteoData else { return }
            strongSelf.meteoData = monthlyMeteoData
            completion(monthlyMeteoData)
            }
    }
    //MARK: - Builder which return array of MonthlyMeteoData from parsed TextData
    private func getMeteoDataModel(parsedTextData: [[String]]) -> [MonthlyMeteoData] {
        return parsedTextData.flatMap { decodeToModel(fromParsedArray: $0) }
    }
    //MARK: - Function-decoder which initialize MontlyMeteoData type value with given array of Strings
    private func decodeToModel(fromParsedArray: [String]) -> MonthlyMeteoData? {
        do {
            let validYear = try yearCheckForValidity(Int(fromParsedArray[0]))
            let validMonth = try monthCheckForValidity(Int(fromParsedArray[1]))
            let maxTemperature = Double(fromParsedArray[2])
            let minTemperature = Double(fromParsedArray[3])
            let daysOfAirFrost = Int(fromParsedArray[4])
            let mmOfRainfall = Double(fromParsedArray[5])
            let hoursOfSunshine = Double(fromParsedArray[6])
            
            return MonthlyMeteoData(year: validYear, month: validMonth, maxTemperature: maxTemperature, minTemperature: minTemperature, daysOfAirFrost: daysOfAirFrost, mmOfRainfall: mmOfRainfall, hoursOfSunshine: hoursOfSunshine)

        } catch {
            print(error)
        }
        return nil
    }
    //MARK: - Function for validating Int as a possible Year
    private func yearCheckForValidity(_ year: Int?) throws -> Int {
        let date = Date()
        let currentCalendarYear = Calendar.current.component(.year, from: date)

        switch year {
        case .some(let year) where (year > 0) && (year <= currentCalendarYear):
            return year
        case .none:
            throw ValidationError.nilFound
        default:
            throw ValidationError.invalidYearNumber
        }
    }
    //MARK: - Function for validating Int as a possible Month
    private func monthCheckForValidity(_ month: Int?) throws -> Int {
        switch month {
        case .some(let month) where (month > 0) && (month <= 12):
            return month
        case .none:
            throw ValidationError.nilFound
        default:
            throw ValidationError.invalidMonthNumber
        }
    }

}
        

