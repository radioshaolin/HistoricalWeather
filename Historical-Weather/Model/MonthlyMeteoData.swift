//
//  MonthlyMeteoData.swift
//  Perpetio-Test-Task
//
//  Created by Radio Shaolin on 19.09.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

// MARK: - MontlyMeteoData
/**
 A struct reprsesent model data type.

 */
struct MonthlyMeteoData {
    
    // MARK: - private fields
    private let yyyy: Int
    private let mm: Month?
    private let tmax: Double?
    private let tmin: Double?
    private let af: Int?
    private let rain: Double?
    private let sun: Double?
    
    //MARK: - Initializer
    init(year: Int, month: Int, maxTemperature: Double?, minTemperature: Double?, daysOfAirFrost: Int?, mmOfRainfall: Double?, hoursOfSunshine: Double?) {

        self.yyyy = year
        self.mm = Month(rawValue: month)
        self.tmax = maxTemperature
        self.tmin = minTemperature
        self.af = daysOfAirFrost
        self.rain = mmOfRainfall
        self.sun = hoursOfSunshine
    }
    
    //MARK: - Computed properties
    var year: Int {
        get {
            return yyyy
        }
    }
    var month: Month {
        get {
            return mm ?? Month(rawValue: 1)!
        }
    }
    var maxTemperature: String {
        get {
            guard let maxTemperature = tmax else { return "-----" }
            return "\(maxTemperature) °C"
        }
    }
    var minTemperature: String {
        get {
            guard let minTemperature = tmin else { return "-----" }
            return "\(minTemperature) °C"
        }
    }
    var daysOfAirFrost: String {
        get {
            guard let daysOfAirFrost = af else { return "-----" }
            return "\(daysOfAirFrost) days"
        }
    }
    var mmOfRainfall: String {
        get {
            guard let dysOfRainfall = rain else { return "-----" }
            return "\(dysOfRainfall) mm"
        }
    }
    var hoursOfSunshine: String {
        get {
            guard let daysOfSunshine = sun else { return "-----" }
            return "\(daysOfSunshine) hours"
        }
    }
}



