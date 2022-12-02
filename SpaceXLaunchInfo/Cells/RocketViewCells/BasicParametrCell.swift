//
//  BasicParametrCell.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 27.11.2022.
//

import UIKit

final class BasicParametrCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    //MARK: - Constants
    
    private enum UI {
        static let itemSize = CGSize(width: 96, height: 96)
        static let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let rowHeight = CGFloat(144)
    }
    
    private let notificationName = Notification.Name(rawValue: Constants.notifaicationName)
    
    //MARK: - Private
    private var basicParametrs: RocketBasicParametrs? {
        didSet {
            elemets = basicParametrs!.toElements(
                isHeightInMeters: Settings.shared.heightInMeters,
                isDiametrMeters: Settings.shared.diametrInMeters,
                isMassKg: Settings.shared.massInKg,
                isLoadInKg: Settings.shared.loadInKg
            )
            parametersCollectionView.reloadData()
        }
    }
    private var elemets: [BasicParametrElement] = []
    private var cells: [BasicParametrCollectionViewCell] = []
    
    private let parametersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UI.itemSize
        layout.sectionInset = UI.sectionInsets

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.alwaysBounceHorizontal = true
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ReusableIds.basicParametersCollectionCell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(parametersCollectionView)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: UI.rowHeight),
            
            parametersCollectionView.topAnchor.constraint(equalTo: topAnchor),
            parametersCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            parametersCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            parametersCollectionView.heightAnchor.constraint(equalToConstant: UI.rowHeight),
            parametersCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        createObservers()
        setupCollectionView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(observerHandler), name: notificationName, object: nil)
    }
    
    @objc
    private func observerHandler() {
        configure(parametrs: basicParametrs!)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReusableIds.basicParametersCollectionCell, for: indexPath) as? BasicParametrCollectionViewCell {
            cell.configure(element: elemets[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elemets.count
    }
    
    // MARK: - Private methods
    private func setupCollectionView() {
        parametersCollectionView.delegate = self
        parametersCollectionView.dataSource = self
        parametersCollectionView.register(BasicParametrCollectionViewCell.self, forCellWithReuseIdentifier: ReusableIds.basicParametersCollectionCell)
        
    }
    
    //MARK: - Public methods
    func configure(parametrs: RocketBasicParametrs) {
        basicParametrs = parametrs
    }
}
