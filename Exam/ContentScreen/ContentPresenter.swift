//
//  ContentPresenter.swift
//  Exam
//
//  Created by Алексей on 21.03.2025.
//

import Foundation
import UIKit

final class ContentPresenter: ContentPresentationLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    // MARK: - Properties
    weak var view: ContentDisplayLogic?
    
    // MARK: - Public Fuctions
    func presentStart(response: ContentModels.LoadStart.Response) {
        let viewModel = ContentModels.LoadStart.ViewModel(
            color: .lightGray
        )
        
        view?.displayStart(viewModel: viewModel)
    }
}
