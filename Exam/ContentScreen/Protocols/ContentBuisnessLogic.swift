//
//  ContentBuisnessLogic.swift
//  Exam
//
//  Created by Алексей on 21.03.2025.
//

import Foundation
import UIKit

protocol ContentBuisnessLogic: AnyObject {
    // MARK: - Functions
    func loadStart(request: ContentModels.LoadStart.Request)
    func loadSettings(request: ContentModels.LoadSettings.Request)
}
