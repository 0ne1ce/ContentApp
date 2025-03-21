//
//  ViewController.swift
//  Exam
//
//  Created by Алексей on 21.03.2025.
//

import UIKit

final class ContentViewController: UIViewController, ContentDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        
    }
    
    // MARK: - Properties
    var interactor: ContentBuisnessLogic
    var router: ContentRouterProtocol
    var settings: SettingsView = SettingsView()
    
    // MARK: - Variables
    var contentCollection: UICollectionView = UICollectionView()
    
    // MARK: - Initialization
    init(interactor: ContentBuisnessLogic, router: ContentRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecyle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadStart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Public functions
    public func loadStart() {
        let request = ContentModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    public func displayStart(viewModel: ContentModels.LoadStart.ViewModel) {
        view.backgroundColor = viewModel.color
    }

}

