//
//  SettingsDisplayLogic.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

protocol SettingsDisplayLogic: AnyObject {
    // MARK: - Functions
    func displayStart(viewModel: SettingsModels.LoadStart.ViewModel)
}
