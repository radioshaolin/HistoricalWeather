//
//  Data.swift
//  Perpetio-Test-Task
//
//  Created by Radio Shaolin on 21.09.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation


// MARK: - MeteoViewModel

class MeteoViewModel {

    private let model: MonthlyMeteoModel
    private(set) var meteoData: [MonthlyMeteoData] = []
    
    init(model: MonthlyMeteoModel) {
        self.model = model
    }
    
    func getMeteoData(completion: @escaping ([MonthlyMeteoData]) -> Void) {
        model.getMeteoData { [weak self] meteoData in
            guard let strongSelf = self else { return }
            strongSelf.meteoData = meteoData
            completion(strongSelf.meteoData)
        }
    }
    //MARK: - Methods returning Data to show in View by choosen Year and Month
    func dataToShow(with pickedYear: Int, with pickedMonth: Int) -> MonthlyMeteoData? {
        guard let choosenYear = self.allYears[optional: pickedYear] else { return nil }
        guard let choosenMonth = self.allMonths[optional: pickedMonth] else { return nil }
        
        return self.meteoData.filter { $0.year == choosenYear }.filter { $0.month.rawValue == choosenMonth }.first
    }
    
    // MARK: Computed properties returned unique collections of Monthes and Years
    private var allYears: [Int] {
        get {
            return self.meteoData.map { $0.year }.unique()
        }
    }
    
    private var allMonths: [Int] {
        get {
            return self.meteoData.map { $0.month }.unique().map { $0.rawValue }
        }
    }

}


    






