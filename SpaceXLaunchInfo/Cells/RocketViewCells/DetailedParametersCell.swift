//
//  DetailedParametersCell.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 27.11.2022.
//

import UIKit

final class DetailedParametersCell: UITableViewCell {
    
    private enum UI {
        static let parameterNameTextSize = CGFloat(16)
        static let parameterNameTextColor = UIColor(red: 0.79, green: 0.79, blue: 0.79, alpha: 1.00)
        static let parameterValueTextSize = CGFloat(16)
        static let parameterValueTextColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        static let parametrMeasurmentTextSize = CGFloat(16)
        static let parametrMeasurmentTextColor = UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1.00)
    }
    
    private let parametrNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.fontGrotesque, size: UI.parameterNameTextSize)
        label.textColor = UI.parameterNameTextColor
        label.textAlignment = .left
        return label
    }()
    
    private let parametrValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.fontGrotesque, size: UI.parameterValueTextSize)
        label.textColor = UI.parameterValueTextColor
        label.textAlignment = .right
        return label
    }()
    
    private let parametrMeasurmentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.fontGrotesque, size: UI.parametrMeasurmentTextSize)
        label.textColor = UI.parametrMeasurmentTextColor
        label.textAlignment = .left
        label.text = ""
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        addSubview(parametrNameLabel)
        addSubview(parametrValueLabel)
        addSubview(parametrMeasurmentsLabel)
        
        NSLayoutConstraint.activate([
            parametrNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            parametrNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            parametrNameLabel.heightAnchor.constraint(equalToConstant: 24),
            parametrNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -(frame.width / 2)),
            
            parametrValueLabel.bottomAnchor.constraint(equalTo: parametrNameLabel.bottomAnchor),
            parametrValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -68),
            parametrValueLabel.heightAnchor.constraint(equalToConstant: 24),
            parametrValueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: frame.width / 2),
            
            parametrMeasurmentsLabel.bottomAnchor.constraint(equalTo: parametrNameLabel.bottomAnchor),
            parametrMeasurmentsLabel.leadingAnchor.constraint(equalTo: parametrValueLabel.trailingAnchor, constant: 8),
            parametrMeasurmentsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            parametrMeasurmentsLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(info: String, value: String, measurment: String?) {
        parametrNameLabel.text = info
        parametrValueLabel.text = value
        if let measurment = measurment {
            parametrMeasurmentsLabel.text = measurment
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
