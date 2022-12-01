
//
//  ViewController.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 29.11.2022.
//

import UIKit

final class RocketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Private properties
    private let networkService = NetworkService()
    private var rockets = [Rocket]()
    private var launches = [Launch]()
    private var rocketImage = UIImage()
    private var basicParametrs: RocketBasicParametrs?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RocketBackgroundImageCell.self, forCellReuseIdentifier: ReusableIds.backgroundImageCell)
        tableView.register(RocketNameLabelCell.self, forCellReuseIdentifier: ReusableIds.rocketNameCell)
        tableView.register(LaunchInfoCell.self, forCellReuseIdentifier: ReusableIds.launchInfoCell)
        tableView.register(DetailedParametersCell.self, forCellReuseIdentifier: ReusableIds.detailedParametersCell)
        tableView.register(SectionNameCell.self, forCellReuseIdentifier: ReusableIds.sectionNameCell)
        tableView.register(LaunchesButtonCell.self, forCellReuseIdentifier: ReusableIds.launchesButtonCell)
        tableView.register(BasicParametrCell.self, forCellReuseIdentifier: ReusableIds.basicParametersCell)
        tableView.backgroundColor = .black
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    private enum Row {
        case header(image: UIImage)
        case rocketName(title: String)
        case basicInfo(parametrs: RocketBasicParametrs)
        case launchInfo(info: String, value: String)
        case detailedInfo(info: String, value: String, measurment: String?)
        case sectionName(title: String)
        case launchesButton
    }
    
    private var rows: [Row] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setUpSubviews()
        setUpConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    //MARK: - Private methods
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
                        self?.getBasicParametrs()
                        self?.loadImage()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    private func getBasicParametrs() {
        let heightInMeters = rockets[0].height.meters ?? 0
        let heightInFeets = rockets[0].height.feet ?? 0
        let diametrInMeters = rockets[0].diameter.meters ?? 0
        let diametrInFeets = rockets[0].diameter.feet ?? 0
        let massInKg = rockets[0].mass.kg
        let massInLb = rockets[0].mass.lb
        let loadInKg = rockets[0].payloadWeights[0].kg
        let loadInLb = rockets[0].payloadWeights[0].lb
        basicParametrs = RocketBasicParametrs(
            heightInMeters: heightInMeters,
            heightInFeets: heightInFeets,
            diametrInMeters: diametrInMeters,
            diametrInFeets: diametrInFeets,
            massInKg: massInKg,
            massInLb: massInLb,
            loadInKg: loadInKg,
            loadInLb: loadInLb
        )
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
        
        if let basicParametrs = basicParametrs {
            let basicParametrs = Row.basicInfo(parametrs: basicParametrs)
            rowsForTable.append(basicParametrs)
        }
        
        let date = Services.dateFormat(date: rockets[0].firstFlight) ?? rockets[0].firstFlight
        let firstLaunch = Row.launchInfo(info: "Первый запуск", value: date)
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
        
        let burnTime = Row.detailedInfo(info: "Время сгорания", value: String(rockets[0].firstStage.burnTimeSec ?? 0) , measurment: "sec")
        rowsForTable.append(burnTime)
        
        let secondStageInfo = Row.sectionName(title: "Вторая ступень")
        rowsForTable.append(secondStageInfo)
        
        let numberOfEnginesInSecondStage = Row.detailedInfo(info: "Количество двигателей", value: String(rockets[0].secondStage.engines) , measurment: nil)
        rowsForTable.append(numberOfEnginesInSecondStage)
        
        let fuelAmountTonsInSecondStage = Row.detailedInfo(info: "Количество топлива", value: String(rockets[0].secondStage.fuelAmountTons) , measurment: "ton")
        rowsForTable.append(fuelAmountTonsInSecondStage)
        
        let burnTimeInSecondStage = Row.detailedInfo(info: "Время сгорания", value: String(rockets[0].secondStage.burnTimeSec ?? 0) , measurment: "sec")
        rowsForTable.append(burnTimeInSecondStage)
        
        let launchesButton = Row.launchesButton
        rowsForTable.append(launchesButton)
        
        rows = rowsForTable
    }
    
    //MARK: - UITableViewDelegate, UITebleViewDataSource
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = rows[indexPath.row]
        
        switch row {
            
        case .header(image: let rocketImage):
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIds.backgroundImageCell) as? RocketBackgroundImageCell {
                cell.configure(with: rocketImage)
                return cell
            }
        case .rocketName(title: let title):
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIds.rocketNameCell) as? RocketNameLabelCell {
                cell.configure(rocketName: title)
                return cell
            }
        case .launchInfo(info: let info, value: let value):
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIds.launchInfoCell) as? LaunchInfoCell {
                cell.configure(info: info, value: value)
                return cell
            }
        case .detailedInfo(info: let info, value: let value, measurment: let measurment):
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIds.detailedParametersCell) as? DetailedParametersCell {
                cell.configure(info: info, value: value, measurment: measurment)
                return cell
            }
        case .sectionName(title: let title):
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIds.sectionNameCell) as? SectionNameCell {
                cell.configure(section: title)
                return cell
            }
        case .launchesButton:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIds.launchesButtonCell) as? LaunchesButtonCell {
                cell.buttonAction = { [unowned self] in
                    print("yes")
                    navigationController?.pushViewController(LaunchViewController(), animated: true)
                }
                return cell
            }
        case .basicInfo(parametrs: let parametrs):
            if let
                cell = tableView.dequeueReusableCell(withIdentifier: ReusableIds.basicParametersCell) as? BasicParametrCell {
                cell.configure(parametrs: parametrs)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    @objc func launchesButtonHandler(sender: UIButton) {
        print("button")
        navigationController?.pushViewController(LaunchViewController(), animated: true)
    }
}
