//
//  YearPicker.swift
//  Perpetio-Test-Task
//
//  Created by Radio Shaolin on 19.09.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//


import UIKit
// MARK: - YearModelPicker
class YearModelPicker: UIPickerView {

    var meteoData: [MonthlyMeteoData]!
    
    var allYears: [String] {
        get {
            return meteoData.map { $0.year }.unique().flatMap { String($0) }

        }
    }
    
}
// MARK: - YearModelPicker: UIPickerViewDataSource

/**
 Implementation of methods conforming to UIPickerViewDataSource Protocol
 */
extension YearModelPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allYears.count
    }
}
// MARK: - YearModelPicker: UIPickerViewDelegate
/**
 Implementation of methods conforming to UIPickerViewDelegate Protocol
 */
extension YearModelPicker: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        NotificationCenter.default.post(name: .pickerChanged, object: self)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allYears[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let myString = allYears[row]
        let myAttributes: [String : Any] = [
            NSForegroundColorAttributeName: UIColor.white,
         NSFontAttributeName: UIFont(name: "Chalkduster", size: 18.0)!]

        return NSAttributedString(string: myString, attributes: myAttributes)
    }
}
