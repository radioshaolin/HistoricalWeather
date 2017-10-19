//
//  ViewController.swift
//  Perpetio-Test-Task
//
//  Created by Radio Shaolin on 19.09.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import UIKit


// MARK: - MeteoViewController
class MeteoViewController: UIViewController {
    // MARK: - Initilization of ViewModel
    private let viewModel = MeteoViewModel(model: MonthlyMeteoModel())
    
    var yearModelPicker: YearModelPicker!
    var monthsModelPicker: MonthsModelPicker!

    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var monthPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var airFrostLabel: UILabel!
    @IBOutlet weak var rainfallLabel: UILabel!
    @IBOutlet weak var sunshineLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerBigLabel: UILabel!
    @IBOutlet weak var headerSmallLabel: UILabel!
    @IBOutlet weak var meteoDataView: UIStackView!
    @IBOutlet weak var pickerPlashka: UIView!
    @IBOutlet weak var pickersView: UIView!
    
    @IBOutlet weak var pickersViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateWeatherLabels), name: .pickerChanged, object: nil)
        
        viewModel.getMeteoData { [weak self] meteoData in
            DispatchQueue.main.async {
                self?.setupPickers()
                self?.updateWeatherLabels()
                self?.showScreenLoadingAnimationChain()
            }}
    }
    // MARK: - Animation of appearence of Data
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setViewsAndLabelsAlphaToZero()
        showScreenLoadingAnimationChain()
    }
    // MARK: - Selector method executable when recieving Notification
    @objc func updateWeatherLabels() {
        let pickedYear = yearPicker.selectedRow(inComponent: 0)
        let pickedMonth = monthPicker.selectedRow(inComponent: 0 )
        let dataToShow = viewModel.dataToShow(with: pickedYear, with: pickedMonth)

        setupLabels(with: dataToShow)
    }
    
    //MARK: - Setuping Pickers, assigning delegates and datasources
    private func setupPickers() {
        yearModelPicker = YearModelPicker()
        yearPicker.delegate = yearModelPicker
        yearPicker.dataSource = yearModelPicker
        yearModelPicker.meteoData = viewModel.meteoData
        
        monthsModelPicker = MonthsModelPicker()
        monthPicker.delegate = monthsModelPicker
        monthPicker.dataSource = monthsModelPicker
        monthsModelPicker.meteoData = viewModel.meteoData
    }
    
    //MARK: - Setuping labels with appropriate data
    private func setupLabels(with dataToShow: MonthlyMeteoData? ) {
        maxTempLabel.text = dataToShow?.maxTemperature ?? "-----"
        minTempLabel.text = dataToShow?.minTemperature ?? "-----"
        airFrostLabel.text = dataToShow?.daysOfAirFrost ?? "-----"
        rainfallLabel.text = dataToShow?.mmOfRainfall ?? "-----"
        sunshineLabel.text = dataToShow?.hoursOfSunshine ?? "-----"
    }
    
    //MARK - Method-helper for animation, settings alpha to zero
    private func setViewsAndLabelsAlphaToZero() {
        backgroundImage.alpha = 0
        gradientView.alpha = 0
        meteoDataView.alpha = 0
        pickersView.alpha = 0
        pickerPlashka.alpha = 0
        headerView.alpha = 0
        headerBigLabel.alpha = 0
        headerSmallLabel.alpha = 0
    }
}

extension MeteoViewController {
    
    // MARK: - Chain of animation
    func showScreenLoadingAnimationChainnn() {
        UIView.animate(withDuration: 0.6, animations: {
            self.gradientView.alpha = 0.55
            self.headerView.alpha = 0.75
            self.backgroundImage.alpha = 0.65
        }) { (true) in
            self.showLablesAnimation()
        }
    }
    
    
    // MARK: - Chain of animation
    func showScreenLoadingAnimationChain() {
        UIView.animate(withDuration: 0.6, animations: {
            self.gradientView.alpha = 0.55
            self.headerView.alpha = 0.75
            self.backgroundImage.alpha = 0.65
        }) { (true) in
            self.showLablesAnimation()
        }
    }
    
    func showLablesAnimation() {
        UIView.animate(withDuration: 0.8, animations: {
            self.headerBigLabel.alpha = 1
            self.headerSmallLabel.alpha = 1
            self.pickersViewHeightConstraint.constant = 195
        }) { (true) in
            self.showMeteoDataAndPickersSpringAnimation()
        }
    }

    func showMeteoDataAndPickersSpringAnimation() {
            UIView.animate(withDuration: 1.3, delay: 0.0,
                           usingSpringWithDamping: 0.36, initialSpringVelocity: 0,
                           options: [.allowUserInteraction, .curveEaseOut], animations: {
                            
                            self.showMeteoDataAndPickersAlphaAnimation()
                            self.pickersViewHeightConstraint.constant = 95
                            self.view.layoutIfNeeded()
                            
            }, completion: nil)
    }

    func showMeteoDataAndPickersAlphaAnimation() {
        UIView.animate(withDuration: 0.8) {
            
            self.meteoDataView.alpha = 1
            self.pickerPlashka.alpha = 0.75
            self.pickersView.alpha = 1
        }
    }

    
    // MARK: - Setting StatusBar to light mode
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
