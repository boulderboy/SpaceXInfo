//
//  LaunchesButtonCell.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 29.11.2022.
//

import UIKit

final class LaunchesButtonCell: UITableViewCell {
    
    private enum UI {
        static let buttonTitle = "Посмотреть запуски"
        static let buttonCornerRadius = CGFloat(20)
        static let buttonBackgrounColor = UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1.00)
    }
    
    private enum Constraints {
        static let buttonTopAnchor = CGFloat(20)
        static let buttonBottomAnchor = CGFloat(-30)
        static let buttonLeadingAnchor = CGFloat(32)
        static let buttonTrailingAnchor = CGFloat(-32)
        static let buttonHeightAnchor = CGFloat(80)
    }
    
    private var launchesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(UI.buttonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = UI.buttonCornerRadius
        button.backgroundColor = UI.buttonBackgrounColor
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc var buttonAction: (() -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        contentView.addSubview(launchesButton)
        
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: Constraints.buttonHeightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            launchesButton.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.buttonTopAnchor),
            launchesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constraints.buttonBottomAnchor),
            launchesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.buttonLeadingAnchor),
            launchesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constraints.buttonTrailingAnchor),
            launchesButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            launchesButton.heightAnchor.constraint(equalToConstant: Constraints.buttonHeightAnchor)
        ])
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        print("button Tapped")
        buttonAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
