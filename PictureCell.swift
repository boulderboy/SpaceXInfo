//
//  PictureCell.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 27.11.2022.
//

import UIKit

final class RocketBackgroundImageCell: UITableViewCell {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let roundedBottom: UIView = {
        let roundedView = UIView()
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        roundedView.layer.cornerRadius = 32
        roundedView.backgroundColor = .black
        roundedView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return roundedView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
    
        addSubview(backgroundImageView)
        addSubview(roundedBottom)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 296),
            backgroundImageView.widthAnchor.constraint(equalToConstant: frame.width),
            
            roundedBottom.bottomAnchor.constraint(equalTo: bottomAnchor),
            roundedBottom.leadingAnchor.constraint(equalTo: leadingAnchor),
            roundedBottom.heightAnchor.constraint(equalToConstant: 48),
            roundedBottom.widthAnchor.constraint(equalToConstant: frame.width)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage) {
        backgroundImageView.image = image
        setNeedsDisplay()
    }
    
}
