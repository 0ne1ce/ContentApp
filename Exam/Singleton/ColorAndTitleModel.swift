//
//  ColorAndTitleModel.swift
//  Exam
//
//  Created by Алексей on 21.03.2025.
//

import Foundation
import UIKit

final class ColorAndTitleModel {
    // MARK: - Constants
    private enum Constants {
        static let initialSliderValue: Float = 1.0
        static let wrapSize: CGFloat = 250
    }
    // MARK: - Properties
    static let shared = ColorAndTitleModel()
    var backgroundColor: UIColor = .white
    let categories: [String] = ["Art", "Memes", "Music", "Films"]
    let categoryColors: [UIColor] =  [.systemRed, .systemGreen, .systemBlue, .systemMint]
    var categoryButtonCounter: Int = .zero
    
    var redValue: Float = Constants.initialSliderValue
    var greenValue: Float = Constants.initialSliderValue
    var blueValue: Float = Constants.initialSliderValue
    var sizeValue: Float = Constants.initialSliderValue
    
    var currentCellSize: CGFloat = Constants.wrapSize
}
