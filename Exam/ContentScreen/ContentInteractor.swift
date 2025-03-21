//
//  ContentInteractor.swift
//  Exam
//
//  Created by Алексей on 21.03.2025.
//

import Foundation
import UIKit

final class ContentInteractor: ContentBuisnessLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    // MARK: - Properties
    var presenter: ContentPresentationLogic
    var worker: ContentWorker
    
    // MARK: - Initialization
    init(presenter: ContentPresentationLogic, worker: ContentWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Public functions
    func loadStart(request: ContentModels.LoadStart.Request) {
        let response = ContentModels.LoadStart.Response(

        )
        presenter.presentStart(response: response)
    }
}
