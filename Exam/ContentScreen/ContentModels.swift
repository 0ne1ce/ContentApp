//
//  ContentModels.swift
//  Exam
//
//  Created by Алексей on 21.03.2025.
//

import Foundation
import UIKit

enum ContentModels {
    enum LoadStart {
        struct Request {
            
        }
        
        struct Response {
            var categoryTitle: String
        }
        
        struct ViewModel {
            var categoryTitle: String
            var settingsImage: UIImage?
            var settingsImageColor: UIColor
        }
    }
    
    enum LoadSettings {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
}
