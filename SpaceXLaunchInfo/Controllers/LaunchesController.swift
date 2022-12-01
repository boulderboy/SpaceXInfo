//
//  LaunchesController.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 30.11.2022.
//

import UIKit

final class LaunchViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource {
    
    private let networkService = NetworkService()
    private var launches: [Launch] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LaunchCell.self, forCellReuseIdentifier: "cellId")
        tableView.allowsSelection = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Falcon 1"
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: Constants.fontGrotesque, size: 16)]
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        setUpConstraints()
        loadData()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadData() {
        DispatchQueue.global().async {
            self.networkService.getLaunches { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let launchesRe):
                        self?.launches = launchesRe.filter { $0.rocket == "5e9d0d95eda69955f709d1eb"}
                    case .failure(let error):
                        print(error)
                    }
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let launch = launches[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as? LaunchCell {
            cell.rocketNameLabel.text = launch.name
            let date = Services.dateFormat(date: String(launch.dateLocal.prefix(10)))
            print(date)
            cell.launchDateLabel.text = date
            cell.launchImage.image = launch.success ?? false ? UIImage(named: "successLaunch") : UIImage(named: "failLaunch")
            return cell
        }
        return UITableViewCell()
    }
    
    
}
