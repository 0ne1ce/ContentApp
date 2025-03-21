//
//  SettingsAssembly.swift
//  MedView
//
//  Created by Алексей on 05.02.2025.
//

import Foundation
import UIKit

final class SettingsAssembly {
    // MARK: - Funtions
    static func build() -> UIViewController {
        let presenter = SettingsPresenter()
        let worker = SettingsWorker()
        let interactor = SettingsInteractor(presenter: presenter, worker: worker)
        let router = SettingsRouter()
        let view = SettingsViewController(interactor: interactor, router: router)
        
        
        presenter.view = view
        
        router.view = view
        
        return view
    }
}
