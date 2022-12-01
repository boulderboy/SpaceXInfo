//
//  LaunchCell.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 30.11.2022.
//

import UIKit

final class LaunchCell: UITableViewCell {
    
    private enum UI {
        static let backgroundLayerColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)
        static let backgroundLayerCornerRadius = CGFloat(24)
        static let rocketNameFontSize = CGFloat(20)
        static let rocketNameTextColor = UIColor.white
        static let launchDateFontSize = CGFloat(16)
        static let launchDateTextColor = UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1.00)
    }
    
    let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.fontGrotesque, size: UI.rocketNameFontSize)
        label.textColor = UI.rocketNameTextColor
        label.textAlignment = .left
        label.text = "Falcon"
        return label
    }()
    
    let launchDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.fontGrotesque, size: UI.launchDateFontSize)
        label.textColor = UI.launchDateTextColor
        label.textAlignment = .left
        label.text = "24 feb 2022"
        return label
    }()
    
    let launchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let backgroundLayer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UI.backgroundLayerColor
        view.layer.cornerRadius = UI.backgroundLayerCornerRadius
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        addSubview(backgroundLayer)
        backgroundLayer.addSubview(launchImage)
        backgroundLayer.addSubview(launchDateLabel)
        backgroundLayer.addSubview(rocketNameLabel)
        
        NSLayoutConstraint.activate([
            backgroundLayer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            backgroundLayer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            backgroundLayer.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            backgroundLayer.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundLayer.heightAnchor.constraint(equalToConstant: 100),
            
            rocketNameLabel.topAnchor.constraint(equalTo: backgroundLayer.topAnchor, constant: 24),
            rocketNameLabel.leadingAnchor.constraint(equalTo: backgroundLayer.leadingAnchor, constant: 24),
            rocketNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: launchImage.leadingAnchor, constant: -30),
            
            launchDateLabel.topAnchor.constraint(equalTo: rocketNameLabel.bottomAnchor),
            launchDateLabel.leadingAnchor.constraint(equalTo: rocketNameLabel.leadingAnchor),
            
            launchImage.topAnchor.constraint(equalTo: backgroundLayer.topAnchor, constant: 34),
            launchImage.trailingAnchor.constraint(equalTo: backgroundLayer.trailingAnchor, constant: -34),
            launchImage.heightAnchor.constraint(equalToConstant: 32),
            launchImage.widthAnchor.constraint(equalToConstant: 32)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
