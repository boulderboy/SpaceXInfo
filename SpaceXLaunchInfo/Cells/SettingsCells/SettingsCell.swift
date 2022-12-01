//
//  SettingsCell.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 01.12.2022.
//

import UIKit

final class SettingsCell: UITableViewCell {
    
    private enum UI {
        static let settingLabelTextColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        static let settingLabelFontSize = CGFloat(16)
        static let segmentedControlBackgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)
        static let segmentedControlTextColor = UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1.00)
    }
    
    private let settingLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UI.settingLabelTextColor
        label.font = UIFont(name: Constants.fontGrotesque, size: UI.settingLabelFontSize)
        label.textAlignment = .left
        label.text = "asdf"
        return label
    }()
    
    private let settingSegmenteControll: UISegmentedControl = {
        let segmentedControll = UISegmentedControl(items: ["m", "ft"])
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        segmentedControll.selectedSegmentIndex = 0
        segmentedControll.backgroundColor = UI.segmentedControlBackgroundColor
        segmentedControll.setTitleTextAttributes([.foregroundColor: UI.settingLabelTextColor], for: .normal)
        segmentedControll.setTitleTextAttributes([.foregroundColor: UI.segmentedControlBackgroundColor], for: .selected)
        return segmentedControll
    }()
    
    var itemsForSegmentedControl: [String] = []

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        backgroundColor = .black
        
        
        contentView.addSubview(settingLabel)
        contentView.addSubview(settingSegmenteControll)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 68),
            
            settingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            settingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            settingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            settingSegmenteControll.topAnchor.constraint(equalTo: settingLabel.topAnchor),
            settingSegmenteControll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -31),
            settingSegmenteControll.heightAnchor.constraint(equalToConstant: 40),
            settingSegmenteControll.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    func configure(name: String, items: [String]) {
        itemsForSegmentedControl = items
        settingSegmenteControll.setTitle(items[0], forSegmentAt: 0)
        settingSegmenteControll.setTitle(items[1], forSegmentAt: 1)
        settingLabel.text = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
