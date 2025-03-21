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
        static let contentInset: UIEdgeInsets = UIEdgeInsets()
        static let collectionTop: CGFloat = 40
        static let contentSize: CGFloat = 275
        static let numberOfItems: Int = 20
        static let minimumInteritemSpacing: CGFloat = 200
    }
    
    // MARK: - Properties
    var interactor: ContentBuisnessLogic
    var router: ContentRouterProtocol
    
    var settingsButton: UIBarButtonItem = UIBarButtonItem()
    lazy var contentCollection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let contentCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        contentCollection.translatesAutoresizingMaskIntoConstraints = false
        
        contentCollection.register(ContentCell.self, forCellWithReuseIdentifier: "ContentCell")
        
        contentCollection.delegate = self
        contentCollection.dataSource = self
        contentCollection.alwaysBounceHorizontal = true
        contentCollection.showsVerticalScrollIndicator = false
        
        return contentCollection
    }()
    
    
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
        view.backgroundColor = ColorAndTitleModel.shared.backgroundColor
        navigationItem.title = ColorAndTitleModel.shared.title

        settingsButton.image = viewModel.settingsImage
        
        settingsButton.target = self
        settingsButton.action = #selector(settingsButtonPressed)
        
        navigationItem.rightBarButtonItem = settingsButton
        navigationItem.rightBarButtonItem?.tintColor = viewModel.settingsImageColor
        
        configureCollection()
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackgroundColor), name: NSNotification.Name("ColorChanged"), object: nil)
    }
    
    func displaySettings(viewModel: ContentModels.LoadSettings.ViewModel) {
        router.showSettingsScreen()
    }
    
    // MARK: - Private functions
    private func configureCollection() {
        
        view.addSubview(contentCollection)
        
        contentCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.collectionTop),
            contentCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        contentCollection.backgroundColor = .clear
    }
    
    // MARK: - Actions
    @objc func settingsButtonPressed() {
        let request = ContentModels.LoadSettings.Request()
        interactor.loadSettings(request: request)
    }
    
    @objc func updateBackgroundColor() {
        view.backgroundColor = ColorAndTitleModel.shared.backgroundColor
    }

}

// MARK: - UICollectionViewDataSource
extension ContentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        ContentCell.reuseIdentifier, for: indexPath)
        guard let contentCell = cell as? ContentCell else {
            return cell
        }
        contentCell.configure()
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowAutoLayout
extension ContentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.contentSize, height: Constants.contentSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell tapped at index \(indexPath.item)")
    }
}
