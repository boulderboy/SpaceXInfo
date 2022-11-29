//
//  BasicParametrCell.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 27.11.2022.
//

import UIKit

final class BasicParametrCell: UITableViewCell, UICollectionViewDelegate {
    
    var basicParametrs: [String: Int]?
    
    private let parametersCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private func setupCollectionView() {
        parametersCollectionView.numberOfItems(inSection: 4)
        parametersCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCellId")
    }
    
}
