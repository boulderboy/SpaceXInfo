//
//  ViewController.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 29.11.2022.
//

import UIKit

final class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let networkService = NetworkService()
    private var rockets = [Rocket]()
    private var rocketImage = UIImage()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "headerId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "rocketNameCellId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "launchInfoCellId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "detailedParametrsCellId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sectionNameCellId")
        tableView.backgroundColor = .black
        return tableView
    }()
    
    private enum Row {
        case header(image: UIImage)
        case rocketName(title: String)
        case launchInfo(info: String, value: String)
        case detailedInfo(info: String, value: String, measurment: String?)
        case sectionName(title: String)
    }
    
    private var rows: [Row] = [] {
            didSet {
                tableView.reloadData()
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setUpSubviews()
        setUpConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpSubviews() {
        view.addSubview(tableView)
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
            self.networkService.getRockets { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let rockets):
                        self?.rockets = rockets
                        self?.loadImage()
                    case .failure(let error):
                        print(error)
                    }
                }
                
            }
        }
    }
    
    private func loadImage() {
        let image = networkService.loadImages(for: rockets[0].flickrImages) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                self.rocketImage = image
                DispatchQueue.main.async {
                    self.createRows()
                }
            }
        }
    }
    
    private func createRows() {
        var rowsForTable: [Row] = []
        
        let headerRow = Row.header(image: rocketImage)
        rowsForTable.append(headerRow)
        
        let rocketName = Row.rocketName(title: rockets[0].name)
        rowsForTable.append(rocketName)
        
        let firstLaunch = Row.launchInfo(info: "Первый запуск", value: rockets[0].firstFlight)
        rowsForTable.append(firstLaunch)
        
        let country = Row.launchInfo(info: "Страна", value: rockets[0].country)
        rowsForTable.append(country)
        
        let costPerLaunch  = Row.launchInfo(info: "Стоимость запуска", value: String(rockets[0].costPerLaunch) )
        rowsForTable.append(costPerLaunch)
        
        let firstStageInfo = Row.sectionName(title: "Первая ступень")
        rowsForTable.append(firstStageInfo)
        
        let numberOfEngines = Row.detailedInfo(info: "Количество двигателей", value: String(rockets[0].firstStage.engines) , measurment: nil)
        rowsForTable.append(numberOfEngines)
        
        let fuelAmountTons = Row.detailedInfo(info: "Количество топлива", value: String(rockets[0].firstStage.fuelAmountTons) , measurment: "ton")
        rowsForTable.append(fuelAmountTons)
        
        let burnTime = Row.detailedInfo(info: "Время сгорания", value: String(rockets[0].firstStage.burnTimeSEC ?? 0) , measurment: "sec")
        rowsForTable.append(burnTime)
        
        let secondStageInfo = Row.sectionName(title: "Вторая ступень")
        rowsForTable.append(secondStageInfo)
        
        let numberOfEnginesInSecondStage = Row.detailedInfo(info: "Количество двигателей", value: String(rockets[0].secondStage.engines) , measurment: nil)
        rowsForTable.append(numberOfEnginesInSecondStage)
        
        let fuelAmountTonsInSecondStage = Row.detailedInfo(info: "Количество топлива", value: String(rockets[0].secondStage.fuelAmountTons) , measurment: "ton")
        rowsForTable.append(fuelAmountTonsInSecondStage)
        
        let burnTimeInSecondStage = Row.detailedInfo(info: "Время сгорания", value: String(rockets[0].secondStage.burnTimeSEC ?? 0) , measurment: "sec")
        rowsForTable.append(burnTimeInSecondStage)
        
        rows = rowsForTable
        print("rows are created")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = rows[indexPath.row]
        print(row)
        
        switch row {
            
        case .header(image: let rocketImage):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "headerId") as? RocketBackgroundImageCell {
                cell.configure(with: rocketImage)
                return cell
            }
        case .rocketName(title: let title):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "rocketNameCellId") as? RocketNameLabelCell {
                cell.configure(rocketName: title)
                return cell
            }
        case .launchInfo(info: let info, value: let value):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "launchInfoCellId") as? LaunchInfoCell {
                cell.configure(info: info, value: value)
                return cell
            }
        case .detailedInfo(info: let info, value: let value, measurment: let measurment):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "detailedParametrsCellId") as? DetailedParametersCell {
                cell.configure(info: info, value: value, measurment: measurment)
                return cell
            }
        case .sectionName(title: let title):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "sectionNameCellId") as? SectionNameCell {
                cell.configure(section: title)
                return cell
            }
        }
        return UITableViewCell()
    }
    
}
