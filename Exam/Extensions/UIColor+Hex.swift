//
//  UIColor+hexToRGB.swift
//  MedView
//
//  Created by Алексей on 03.02.2025.
//
import Foundation
import UIKit

// MARK: - Color convertation methods
extension UIColor {
    //MARK: - Variables
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
    
    //MARK: - Initialization
    convenience init(hex: String) {
        let formattedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb : UInt64 = 0
        Scanner (string: formattedHex).scanHexInt64(&rgb)
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        let alpha = 1.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
