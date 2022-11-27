//
//  RocketNameLabalRow.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 27.11.2022.
//

import UIKit

final class RocketNameLabelCell: UITableViewCell {
    
    let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.fontGrotesque, size: 24)
        return label
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "Setting"), for: .normal)
        button.contentMode = .scaleToFill
        return button
    }()
    
    var rocketName: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        addSubview(rocketNameLabel)
        addSubview(settingsButton)
        
        if let rocketName = rocketName {
            rocketNameLabel.text = rocketName
        }
        
        NSLayoutConstraint.activate([
            rocketNameLabel.topAnchor.constraint(equalTo: topAnchor),
            rocketNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            rocketNameLabel.heightAnchor.constraint(equalToConstant: 32),
            rocketNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: settingsButton.leadingAnchor, constant: -135),
            
            settingsButton.topAnchor.constraint(equalTo: rocketNameLabel.topAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            settingsButton.heightAnchor.constraint(equalToConstant: 32),
            settingsButton.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
