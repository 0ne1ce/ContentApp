//
//  SettingsBuisnessLogic.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

protocol SettingsBuisnessLogic: AnyObject {
    // MARK: - Functions
    func loadStart(request: SettingsModels.LoadStart.Request)
}
