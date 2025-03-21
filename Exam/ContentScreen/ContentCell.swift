//
//  ContentCell.swift
//  Exam
//
//  Created by Алексей on 21.03.2025.
//

import UIKit

final class ContentCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        static let offset: CGFloat = 10
        static let titleTopOffset: CGFloat = 15
        static let innerOffsetV: CGFloat = 5
        static let innerOffsetH: CGFloat = 10
        static let wrapCornerRadius: CGFloat = 15
        static let backgroundColor: UIColor = .white
        static let wrapSize: CGFloat = 250
        
        static let fontSize: CGFloat = 20
        
        static let labelHeight: CGFloat = 30
        static let labelCornerRadius: CGFloat = 5
        
    }
    // MARK: - Properties
    static let reuseIdentifier: String = "ContentCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureWrap()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configure() {
        wrapView.backgroundColor = .cyan
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        
        wrapView.pinCenter(to: self)
        wrapView.setHeight(Constants.wrapSize)
        wrapView.setWidth(Constants.wrapSize)
        
        wrapView.layer.cornerRadius = Constants.wrapCornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
        
    }
}
