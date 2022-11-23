//
//  RocketViewController.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 22.11.2022.
//

import UIKit

let backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    return imageView
}()

let infoImageView = UIView()

final class RocketViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoImageView.translatesAutoresizingMaskIntoConstraints = false
        infoImageView.backgroundColor = .yellow
        
        view.addSubview(infoImageView)
        NSLayoutConstraint.activate([
            infoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoImageView.heightAnchor.constraint(equalToConstant: 50),
            infoImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
