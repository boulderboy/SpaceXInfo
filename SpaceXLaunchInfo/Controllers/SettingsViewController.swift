//
//  SettingsViewController.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 01.12.2022.
//

import UIKit

final class SettingsViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource {
        
        private let tableView: UITableView = {
            let tableView = UITableView(frame: .zero)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(SettingsCell.self, forCellReuseIdentifier: "settingCellId")
            tableView.allowsSelection = false
            return tableView
        }()
        
        private var settings = [SettingsOptions.height,
                                SettingsOptions.diametr,
                                SettingsOptions.mass,
                                SettingsOptions.load
        ]
        private struct SettingsOptions {
            static let height = ["name": ["Bысота"],
                                 "items": measurmentUnits.distance]
            static let diametr = ["name": ["Диаметр"],
                                  "items": measurmentUnits.distance]
            static let mass = ["name": ["Масса"],
                               "items": measurmentUnits.mass]
            static let load = ["name": ["Загрузка"],
                               "items": measurmentUnits.mass]
        }
        private struct measurmentUnits {
            static let distance = ["m", "ft"]
            static let mass = ["kg", "lb"]
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()

            navigationController?.navigationBar.barStyle = .default
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: Constants.fontGrotesque, size: 25)]
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(dismissButtonHandler))
            view.backgroundColor = .black
            tableView.backgroundColor = .black
            title = "Настройки"
            tableView.delegate = self
            tableView.dataSource = self
            view.addSubview(tableView)
            setUpConstraints()
            
        }
        
        private func setUpConstraints() {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
        @objc
        private func dismissButtonHandler() {
            dismiss(animated: true)
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "settingCellId") as? SettingsCell {
                let setting = settings[indexPath.row]
                let settingName = setting["name"]?[0]
                let settingItems = setting["items"]
                    cell.configure(name: settingName ?? "", items: settingItems ?? ["a", "b"])
                    return cell
            }
            return UITableViewCell()
        }
        
        
    }

