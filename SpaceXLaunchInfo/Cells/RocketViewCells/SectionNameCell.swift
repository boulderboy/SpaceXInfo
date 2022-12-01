//
//  SectionNameCell.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 29.11.2022.
//

import UIKit

final class SectionNameCell: UITableViewCell {
    
    private enum UI {
        static let sectionNameFontSize = CGFloat(16)
        static let sectionNameFontColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
    }
    
    private let sectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: Constants.fontGrotesque, size: UI.sectionNameFontSize)
        label.textColor = UI.sectionNameFontColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        addSubview(sectionNameLabel)
        
        NSLayoutConstraint.activate([
            sectionNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
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
