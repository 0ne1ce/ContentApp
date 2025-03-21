//
//  SettingsViewController.swift
//  MedView
//
//  Created by Алексей on 03.02.2025.
//

import Foundation
import UIKit

final class SettingsViewController: UIViewController, SettingsDisplayLogic {
    // MARK: - Constants
    private enum Constants {
        static let titleOffsetH: CGFloat = 100
        static let titleTopOffset: CGFloat = 25
        static let titleHeight: CGFloat = 20
        static let titleWidth: CGFloat = 100
        
        static let panelRadius: CGFloat = 20
        static let panelOffsetH: CGFloat = 25
        static let panelOffsetBottom: CGFloat = 250
        
        static let categoryButtonRadius: CGFloat = 10
        static let categoryButtonOffsetTop: CGFloat = 15
        static let categoryButtonHeight: CGFloat = 35
        static let categoryButtonColors: [UIColor] =  [.systemRed, .systemGreen, .systemBlue, .systemMint]
        static let colorSwitchTime: Double = 0.5
    }
    
    // MARK: - Properties
    var interactor: SettingsBuisnessLogic
    var router: SettingsRouterProtocol
    
    var panel: UIStackView = UIStackView()
    var titleLabel: UILabel = UILabel()
    var categoryButton: UIButton = UIButton(type: .custom)
    var categoryButtonCounter: Int = 0
    
    let sliderRed: SettingsSlider = SettingsSlider()
    let sliderGreen: SettingsSlider = SettingsSlider()
    let sliderBlue: SettingsSlider = SettingsSlider()
    let sizeSlider: SettingsSlider = SettingsSlider()
    
    
    // MARK: - Initialization
    init(interactor: SettingsBuisnessLogic, router: SettingsRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        loadStart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Public functions
    func loadStart() {
        let request = SettingsModels.LoadStart.Request()
        interactor.loadStart(request: request)
    }
    
    func displayStart(viewModel: SettingsModels.LoadStart.ViewModel) {
        configureTitleLabel(viewModel: viewModel)
        configurePanel(viewModel: viewModel)
    }
    
    // MARK: - Private functions
    private func configure() {
        view.backgroundColor = ColorAndTitleModel.shared.backgroundColor
    }
    
    private func configureTitleLabel(viewModel: SettingsModels.LoadStart.ViewModel) {
        view.addSubview(titleLabel)
        
        titleLabel.text = viewModel.titleLabelText
        titleLabel.textColor = viewModel.titleTextColor
        titleLabel.textAlignment = .center
        titleLabel.font = viewModel.titleFont
        
        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.topAnchor, Constants.titleTopOffset)
        titleLabel.setHeight(Constants.titleHeight)
        titleLabel.setWidth(Constants.titleWidth)
    }
    
    private func configurePanel(viewModel: SettingsModels.LoadStart.ViewModel) {
        panel.axis = .vertical
        view.addSubview(panel)
        panel.layer.cornerRadius = Constants.panelRadius
        panel.clipsToBounds = true
        
        sliderRed.SetTitle(title: viewModel.redSliderTitle)
        sliderGreen.SetTitle(title: viewModel.greenSliderTitle)
        sliderBlue.SetTitle(title: viewModel.blueSliderTitle)
        sizeSlider.SetTitle(title: viewModel.sizeSliderTitle)
        
        for slider in [sliderRed, sliderGreen, sliderBlue, sizeSlider] {
            slider.SetMinMax(min: viewModel.sliderMinValue, max: viewModel.sliderMaxValue)
            slider.backgroundColor = ColorAndTitleModel.shared.backgroundColor
            panel.addArrangedSubview(slider)
        }
        
        panel.pinHorizontal(to: view, Constants.panelOffsetH)
        panel.pinBottom(to: view, Constants.panelOffsetBottom)
        
        sliderRed.valueChanged = { [weak self] value in
            self?.changeBackgroundColor()
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.changeBackgroundColor()
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.changeBackgroundColor()
        }
        

        categoryButton.setTitle(viewModel.categoryButtonText, for: .normal)
        categoryButton.titleLabel?.textColor = viewModel.categoryButtonTextColor
        categoryButton.backgroundColor = Constants.categoryButtonColors[0]
        categoryButton.layer.cornerRadius = Constants.categoryButtonRadius
        categoryButton.addTarget(self, action: #selector(categoryButtonPressed), for: .touchUpInside)
        categoryButton.setHeight(Constants.categoryButtonHeight)
        
        panel.addArrangedSubview(categoryButton)
    }
    
    private func changeBackgroundColor() {
        let currentColor: UIColor = UIColor(
            red: CGFloat(
                sliderRed.slider.value
            ),
            green: CGFloat(
                sliderGreen.slider.value
            ),
            blue: CGFloat(
                sliderBlue.slider.value
            ),
            alpha: 1
        )
        self.view.backgroundColor = currentColor
        sliderRed.backgroundColor = currentColor
        sliderGreen.backgroundColor = currentColor
        sliderBlue.backgroundColor = currentColor
        sizeSlider.backgroundColor = currentColor
        ColorAndTitleModel.shared.backgroundColor = currentColor
        NotificationCenter.default.post(name: NSNotification.Name("ColorChanged"), object: nil)
    }
    
    // MARK: - Actions
    @objc func categoryButtonPressed() {
        categoryButtonCounter += 1
        UIView.animate(
                withDuration: Constants.colorSwitchTime,
                animations: {[self] in
                    categoryButton.backgroundColor = Constants
                        .categoryButtonColors[categoryButtonCounter % 4]
                    },
                    completion: {
                        [weak self] _ in
                        self?.categoryButton.isEnabled = true
        })
        
    }
}
