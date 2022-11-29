//
//  SectionNameCell.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 29.11.2022.
//

import UIKit

final class SectionNameCell: UITableViewCell {
    
    private let sectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: Constants.fontGrotesque, size: 16)
        label.textColor = UIColor(red: 0.79, green: 0.79, blue: 0.79, alpha: 1.00)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(sectionNameLabel)
        
        NSLayoutConstraint.activate([
            sectionNameLabel.topAnchor.constraint(equalTo: topAnchor),
            sectionNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            sectionNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            sectionNameLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(section: String) {
        sectionNameLabel.text = section.uppercased()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
