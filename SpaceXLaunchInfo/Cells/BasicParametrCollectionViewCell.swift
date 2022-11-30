//
//  BasicParametrCollectionViewCell.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 27.11.2022.
//

import UIKit

final class BasicParametrCollectionViewCell: UICollectionViewCell {
    
    private let parametrValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.fontGrotesque, size: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let parameterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.fontGrotesque, size: 14)
        label.textColor = UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1.00)
        label.textAlignment = .center
        return label
    }()
    
    private let measurmentUnitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.fontGrotesque, size: 14)
        label.textColor = UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1.00)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)
        layer.cornerRadius = 32
        
        addSubview(parameterNameLabel)
        addSubview(parametrValueLabel)
        addSubview(measurmentUnitLabel)
        
        NSLayoutConstraint.activate([
            parametrValueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            parametrValueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            parametrValueLabel.widthAnchor.constraint(equalToConstant: frame.width),
            parametrValueLabel.heightAnchor.constraint(equalToConstant: 24),
            
            parameterNameLabel.topAnchor.constraint(equalTo: parametrValueLabel.bottomAnchor),
            parameterNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            parametrValueLabel.widthAnchor.constraint(equalToConstant: frame.width),
            parametrValueLabel.heightAnchor.constraint(equalToConstant: 20),
            
            measurmentUnitLabel.topAnchor.constraint(equalTo: parameterNameLabel.topAnchor),
            measurmentUnitLabel.leadingAnchor.constraint(equalTo: parameterNameLabel.trailingAnchor, constant: 2),
            measurmentUnitLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    convenience init(parametrName: String, parametrValue: Double) {
        self.init()
        parametrValueLabel.text = String(parametrValue) 
        parameterNameLabel.text = parametrName
    }
    
    func configure(element: BasicParametrElement) {
        parametrValueLabel.text = element.value
        parameterNameLabel.text = element.description + ", " + element.unitType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

