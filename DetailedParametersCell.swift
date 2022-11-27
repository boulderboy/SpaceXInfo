//
//  DetailedParametersCell.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 27.11.2022.
//

import UIKit

final class DetailedParametersCell: UITableViewCell {
    
    private let parametrNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.fontGrotesque, size: 16)
        label.textColor = UIColor(red: 0.79, green: 0.79, blue: 0.79, alpha: 1.00)
        label.textAlignment = .left
        return label
    }()
    
    private let parametrValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.fontGrotesque, size: 16)
        label.textColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        label.textAlignment = .right
        return label
    }()
    
    private let parametrMeasurmentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.fontGrotesque, size: 16)
        label.textColor = UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1.00)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        addSubview(parametrNameLabel)
        addSubview(parametrValueLabel)
        addSubview(parametrMeasurmentsLabel)
        
        NSLayoutConstraint.activate([
            parametrNameLabel.topAnchor.constraint(equalTo: topAnchor),
            parametrNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            parametrNameLabel.heightAnchor.constraint(equalToConstant: 24),
            parametrNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -(frame.width / 2)),
            
            parametrValueLabel.topAnchor.constraint(equalTo: topAnchor),
            parametrValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -68),
            parametrValueLabel.heightAnchor.constraint(equalToConstant: 24),
            parametrValueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: frame.width / 2)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}