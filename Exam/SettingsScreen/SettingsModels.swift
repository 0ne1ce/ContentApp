//
//  SettingsModels.swift
//  MedView
//
//  Created by Алексей on 23.02.2025.
//

import Foundation
import UIKit

enum SettingsModels {
    enum LoadStart {
        struct Request {
            
        }
        
        struct Response {
            var titleLabelText: String
            var sliderMinValue: Double
            var sliderMaxValue: Double
            var categoryButtonText: String
        }
        
        struct ViewModel {
            var titleLabelText: String
            var sliderMinValue: Double
            var sliderMaxValue: Double
            var titleTextColor: UIColor
            var titleFont: UIFont
            var redSliderTitle: String
            var greenSliderTitle: String
            var blueSliderTitle: String
            var sizeSliderTitle: String
            var categoryButtonText: String
            var categoryButtonTextColor: UIColor
        }
    }
}
