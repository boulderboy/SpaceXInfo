//
//  BasicParametrCell.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 27.11.2022.
//

import UIKit

final class BasicParametrCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    var basicParametrs: RocketBasicParametrs? {
        didSet {
            elemets = basicParametrs!.toElements(isHeightInMeters: true, isDiametrMeters: true, isMassKg: true, isLoadInKg: false)
            parametersCollectionView.reloadData()
        }
    }
    
    var elemets = [BasicParametrElement]()
    
    var cells: [BasicParametrCollectionViewCell] = []
    
    private let parametersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 96, height: 96)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.alwaysBounceHorizontal = true
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCellId")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .red
        contentView.addSubview(parametersCollectionView)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 144),
            
            parametersCollectionView.topAnchor.constraint(equalTo: topAnchor),
            parametersCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            parametersCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            parametersCollectionView.heightAnchor.constraint(equalToConstant: 144),
            parametersCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        setupCollectionView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        parametersCollectionView.delegate = self
        parametersCollectionView.dataSource = self
        parametersCollectionView.register(BasicParametrCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCellId")
        
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellId", for: indexPath) as? BasicParametrCollectionViewCell {
            cell.configure(element: elemets[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elemets.count
    }
    
    func configure(parametrs: RocketBasicParametrs) {
        self.basicParametrs = parametrs
    }
    
}
