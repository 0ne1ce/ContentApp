//
//  UIFont.swift
//  MedView
//
//  Created by Алексей on 03.02.2025.
//

import Foundation
import UIKit

// MARK: - Font methods
extension UIFont {

    var bold: UIFont {
        return with(.traitBold)
    }
    
    var italic: UIFont {
        return with(.traitItalic)
    }
    
    var italicBold: UIFont {
        return with([.traitItalic, .traitBold])
    }
    
    // MARK: - Functions
    func with(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits).union(self.fontDescriptor.symbolicTraits)) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
}
