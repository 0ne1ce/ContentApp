//
//  ColorSlider.swift
//  Exam
//
//  Created by Алексей on 21.03.2025.
//

import UIKit

final class SettingsSlider: UIView {
    //MARK: - Constants
    enum Constants {
        static let titleViewTop: CGFloat = 10
        static let titleViewLeading: CGFloat = 20
        
        static let sliderBottom: CGFloat = -10
        static let sliderLeading: CGFloat = 20
    }
    
    //MARK: - Properties
    var valueChanged: ((Double) -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    
    // MARK:- Initialization
    init() {
        super.init(frame: .zero)
        titleView.textColor = .black
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    public func SetTitle(title:String) {
        titleView.text = title
    }
    
    public func SetMinMax(min: Double, max: Double) {
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
    }
    
    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = ColorAndTitleModel.shared.backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleViewTop),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleViewLeading),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.sliderBottom),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeading),
            
        ])
    }
    
    // MARK: - Actions
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
