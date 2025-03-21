//
//  ContentAssembly.swift
//  Exam
//
//  Created by Алексей on 21.03.2025.
//
import Foundation
import UIKit

final class ContentAssembly {
    // MARK: - Functions
    static func build() -> UIViewController {
        let presenter = ContentPresenter()
        let worker = ContentWorker()
        let interactor = ContentInteractor(presenter: presenter, worker: worker)
        let router = ContentRouter()
        let view = ContentViewController(interactor: interactor, router: router)
        
        presenter.view = view
        
        router.view = view
        
        return view
    }
}
