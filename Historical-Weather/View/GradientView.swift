//
//  GradientLayer.swift
//  Perpetio-Test-Task
//
//  Created by Radio Shaolin on 22.09.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import UIKit

// MARK: - GradientView
/**
 Handy class for InterfaceBuilder added some missed properties
 */
@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor.cgColor, secondColor.cgColor ]
    }
    
}
