//
//  TableViewAnimator.swift
//  MedView
//
//  Created by Алексей on 02.03.2025.
//

import Foundation
import UIKit

final class CollectionViewAnimator {
    // MARK: - Properties
    private let animation: CollectionCellAnimation
    
    // MARK: - Initialization
    init(animation: @escaping CollectionCellAnimation) {
        self.animation = animation
    }
    
    // MARK: - Public functions
    func animate(cell: UICollectionViewCell, at indexPath: IndexPath, for collectionView: UICollectionView) {
        animation(cell, indexPath, collectionView)
    }
}
