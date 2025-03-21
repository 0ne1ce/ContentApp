//
//  ViewController.swift
//  Exam
//
//  Created by Алексей on 21.03.2025.
//

import UIKit

typealias CollectionCellAnimation = (UICollectionViewCell, IndexPath, UICollectionView) -> Void

final class ContentViewController: UIViewController, ContentDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let contentInset: UIEdgeInsets = UIEdgeInsets()
        static let collectionTop: CGFloat = 40
        static let contentSize: CGFloat = 275
        static let numberOfItems: Int = 20
        static let minimumInteritemSpacing: CGFloat = 200
        
        static let usingSpringWithDampingValue: CGFloat = 0.75
        static let initialSpringVelocityValue: CGFloat = 0.4
        static let cellsAnimationDuration: CGFloat = 1.2
        static let delayFactor: CGFloat = 0.05
        static let widthForRowAnimated: CGFloat = 100
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
        navigationItem.title = ColorAndTitleModel.shared.categories[ColorAndTitleModel.shared.categoryButtonCounter % 4]
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
        navigationItem.title = viewModel.categoryTitle

        settingsButton.image = viewModel.settingsImage
        
        settingsButton.target = self
        settingsButton.action = #selector(settingsButtonPressed)
        
        navigationItem.rightBarButtonItem = settingsButton
        navigationItem.rightBarButtonItem?.tintColor = viewModel.settingsImageColor
        
        configureCollection()
        configureNotifications()
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
    
    private func configureNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(
                updateBackgroundColor
            ),
            name: NSNotification.Name(
                "ColorChanged"
            ),
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateCategoryTitle),
            name: NSNotification.Name("TitleChanged"),
            object: nil
        )
    }
    
    private func moveLeftBounceAnimation(rowWidth: CGFloat, duration: TimeInterval, delayFactor: Double) -> CollectionCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: rowWidth, y: .zero)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                usingSpringWithDamping: Constants.usingSpringWithDampingValue,
                initialSpringVelocity: Constants.initialSpringVelocityValue,
                options: [.curveEaseInOut],
                animations:  {
                    cell.transform = CGAffineTransform(translationX: .zero, y: .zero)
                }
            )
        }
    }
    
    // MARK: - Actions
    @objc func settingsButtonPressed() {
        let request = ContentModels.LoadSettings.Request()
        interactor.loadSettings(request: request)
    }
    
    @objc func updateBackgroundColor() {
        view.backgroundColor = ColorAndTitleModel.shared.backgroundColor
    }
    
    @objc func updateCategoryTitle(notification: Notification) {
        if let newTitle = notification.userInfo?["newTitle"] as? String {
            navigationItem.title = newTitle
            contentCollection.reloadData()
        }
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
        var currentCategoryColorIndex = ColorAndTitleModel.shared.categoryButtonCounter
        contentCell.wrapView.backgroundColor = ColorAndTitleModel.shared.categoryColors[currentCategoryColorIndex % 4]
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let animation = moveLeftBounceAnimation(
            rowWidth: Constants.widthForRowAnimated,
            duration: Constants.cellsAnimationDuration,
            delayFactor: Constants.delayFactor
        )
        let animator = CollectionViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, for: contentCollection)
    }
}
