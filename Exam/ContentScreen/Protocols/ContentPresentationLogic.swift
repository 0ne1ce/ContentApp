//
//  ContentPresentationLogic.swift
//  Exam
//
//  Created by Алексей on 21.03.2025.
//

import Foundation
import UIKit

protocol ContentPresentationLogic: AnyObject {
    // MARK: - Functions
    func presentStart(response: ContentModels.LoadStart.Response)
    
}
