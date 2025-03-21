//
//  SettingsInteractor.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class SettingsInteractor: SettingsBuisnessLogic {
    // MARK: - Constants
    private enum Constants {
        static let settingsLabelText: String = "Settings"
        
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let categoryButtonLabelText: String = "Change content category"
    }
    
    // MARK: - Properties
    var presenter: SettingsPresentationLogic
    var worker: SettingsWorker
    
    // MARK: - Initialization
    init(presenter: SettingsPresentationLogic, worker: SettingsWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public functions
    func loadStart(request: SettingsModels.LoadStart.Request) {
        let response = SettingsModels.LoadStart.Response(
            titleLabelText: Constants.settingsLabelText,
            sliderMinValue: Constants.sliderMin,
            sliderMaxValue: Constants.sliderMax,
            categoryButtonText: Constants.categoryButtonLabelText
        )
        presenter.presentStart(response: response)
    }
}
