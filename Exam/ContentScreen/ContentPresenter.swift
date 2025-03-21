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
        static let image: UIImage? = UIImage(systemName: "gearshape.fill")
    }
    
    // MARK: - Properties
    weak var view: ContentDisplayLogic?
    
    // MARK: - Public Fuctions
    func presentStart(response: ContentModels.LoadStart.Response) {
        let viewModel = ContentModels.LoadStart.ViewModel(
            categoryTitle: response.categoryTitle,
            settingsImage: Constants.image,
            settingsImageColor: .gray
        )
        
        view?.displayStart(viewModel: viewModel)
    }
    
    func presentSettings(response: ContentModels.LoadSettings.Response) {
        let viewModel = ContentModels.LoadSettings.ViewModel()
        view?.displaySettings(viewModel: viewModel)
    }
}
