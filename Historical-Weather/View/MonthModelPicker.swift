//
//  MonthModelPicker.swift
//  Perpetio-Test-Task
//
//  Created by Radio Shaolin on 19.09.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import UIKit

// MARK: - MonthsModelPicker
class MonthsModelPicker: UIPickerView {
    
    var meteoData: [MonthlyMeteoData]!
    
    var allMonths: [String] {
        get {
            return meteoData.map { $0.month }.unique().map { $0.description }
        }
    }
}
// MARK: - MonthsModelPicker: UIPickerViewDataSource
/**
 Implementation of methods conforming to UIPickerViewDataSource Protocol
 */
extension MonthsModelPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allMonths.count
    }
}
// MARK: - MonthsModelPicker: UIPickerViewDelegate
/**
 Implementation of methods conforming to UIPickerViewDelegate Protocol.
 */
extension MonthsModelPicker: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        NotificationCenter.default.post(name: .pickerChanged, object: self)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allMonths[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let myString = allMonths[row]
        let myAttributes: [String : Any] = [
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "Chalkduster", size: 18.0)!]
        
        return NSAttributedString(string: myString, attributes: myAttributes)
    }
}
