//
//  LaunchesButtonCell.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 29.11.2022.
//

import UIKit

final class LaunchesButtonCell: UITableViewCell {
    
    var launchesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Посмотреть запуски", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1.00)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        addSubview(launchesButton)
        
        NSLayoutConstraint.activate([
            launchesButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            launchesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            launchesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            launchesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            launchesButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            launchesButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
