//
//  ContentDisplayLogic.swift
//  Exam
//
//  Created by Алексей on 21.03.2025.
//

import Foundation
import UIKit

protocol ContentDisplayLogic: AnyObject {
    // MARK: - Functions
    func displayStart(viewModel: ContentModels.LoadStart.ViewModel)
    func displaySettings(viewModel: ContentModels.LoadSettings.ViewModel)
}
