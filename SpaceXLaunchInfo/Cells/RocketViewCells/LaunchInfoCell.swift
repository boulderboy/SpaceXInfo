//
//  LaunchInfoCell.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 29.11.2022.
//

import UIKit

final class LaunchInfoCell: UITableViewCell {
    
    private enum UI {
        static let infoTextSize = CGFloat(16)
        static let infoTextColor = UIColor(red: 0.79, green: 0.79, blue: 0.79, alpha: 1.00)
        static let valueTextSize = CGFloat(16)
        static let valueTextColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
    }
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: Constants.fontGrotesque, size: UI.infoTextSize)
        label.textColor = UI.infoTextColor
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont(name: Constants.fontGrotesque, size: UI.valueTextSize)
        label.textColor = UI.valueTextColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        addSubview(infoLabel)
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            infoLabel.topAnchor.constraint(equalTo: topAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 24),
            
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            valueLabel.topAnchor.constraint(equalTo: infoLabel.topAnchor),
            valueLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
    }
    
    func configure(info: String, value: String) {
        infoLabel.text = info
        valueLabel.text = value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
