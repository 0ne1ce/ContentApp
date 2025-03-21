//
//  ColorAndTitleModel.swift
//  Exam
//
//  Created by Алексей on 21.03.2025.
//

import Foundation
import UIKit

final class ColorAndTitleModel {
    // MARK: - Properties
    static let shared = ColorAndTitleModel()
    var backgroundColor: UIColor = .white
    var title: String = "Content category"
}
