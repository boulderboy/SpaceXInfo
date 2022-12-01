//
//  RocketNameLabalRow.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 27.11.2022.
//

import UIKit

final class RocketNameLabelCell: UITableViewCell {
    
    private enum UI {
        static let parameterNameTextSize = CGFloat(24)
        static let parameterNameTextColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        static let buttonImageName = "Setting"
    }
    
    private let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.fontGrotesque, size: UI.parameterNameTextSize)
        label.textColor = UI.parameterNameTextColor
        return label
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: UI.buttonImageName), for: .normal)
        button.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    var buttonAction: (() -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        contentView.addSubview(rocketNameLabel)
        contentView.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 50),
            
            rocketNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            rocketNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            rocketNameLabel.heightAnchor.constraint(equalToConstant: 32),
            rocketNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            rocketNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: settingsButton.leadingAnchor, constant: -135),
            
            settingsButton.topAnchor.constraint(equalTo: rocketNameLabel.topAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            settingsButton.heightAnchor.constraint(equalToConstant: 32),
            settingsButton.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    @objc
    private func buttonTapped() {
        buttonAction?()
    }
    
    func configure(rocketName: String) {
        rocketNameLabel.text = rocketName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
