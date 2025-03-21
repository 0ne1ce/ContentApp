//
//  SettingsPresenter.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class SettingsPresenter: SettingsPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        static let titleFont: UIFont = .systemFont(ofSize: 18).bold
        
        static let red: String = "Red"
        static let blue: String = "Blue"
        static let green: String = "Green"
        static let size: String = "Size"
        
    }
    
    // MARK: - Properties
    var view: SettingsDisplayLogic?
    
    // MARK: - Fuctions
    func presentStart(response: SettingsModels.LoadStart.Response) {
        let viewModel = SettingsModels.LoadStart.ViewModel(
            titleLabelText: response.titleLabelText,
            sliderMinValue: response.sliderMinValue,
            sliderMaxValue: response.sliderMaxValue,
            titleTextColor: .black,
            titleFont: Constants.titleFont,
            redSliderTitle: Constants.red,
            greenSliderTitle: Constants.green,
            blueSliderTitle: Constants.blue,
            sizeSliderTitle: Constants.size,
            categoryButtonText: response.categoryButtonText,
            categoryButtonTextColor: .white
        )
        view?.displayStart(viewModel: viewModel)
    }
}
