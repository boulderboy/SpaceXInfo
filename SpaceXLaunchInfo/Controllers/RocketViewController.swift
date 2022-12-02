
//
//  ViewController.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 29.11.2022.
//

import UIKit

protocol RocketViewCotntrollerDelegate: AnyObject {
    func setSettings(settings: Settings)
}

final class RocketViewController: UIViewController,
                                  UITableViewDelegate,
                                  UITableViewDataSource,
                                  RocketViewCotntrollerDelegate {
    
    //MARK: - Private properties
    private let networkService = NetworkService()
    private var rocket: Rocket?
    private var rocketImage = UIImage()
    private var basicParametrs: RocketBasicParametrs?
    
    init(rocket: Rocket) {
        super.init(nibName: nil, bundle: nil)
        self.rocket = rocket
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var settings = Settings()
    
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
        setUpSubviews()
        setUpConstraints()
        tableView.delegate = self
        tableView.dataSource = self

        getBasicParametrs()
        loadImage()
    }
    
    func setSettings(settings: Settings) {
        self.settings = settings
        tableView.reloadData()
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    private func loadData() {
        DispatchQueue.global().async {
            self.networkService.getRockets { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let rockets):
                        self?.loadImage()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    private func getBasicParametrs() {
        guard let rocket = rocket else { return }
        let heightInMeters = rocket.height.meters ?? 0
        let heightInFeets = rocket.height.feet ?? 0
        let diametrInMeters = rocket.diameter.meters ?? 0
        let diametrInFeets = rocket.diameter.feet ?? 0
        let massInKg = rocket.mass.kg
        let massInLb = rocket.mass.lb
        let loadInKg = rocket.payloadWeights[0].kg
        let loadInLb = rocket.payloadWeights[0].lb
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
        guard let rocket = rocket else { return }
        networkService.loadImages(for: rocket.flickrImages) { result in
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
        guard let rocket = rocket else { return }
        
        let headerRow = Row.header(image: rocketImage)
        rowsForTable.append(headerRow)
        
        let rocketName = Row.rocketName(title: rocket.name)
        rowsForTable.append(rocketName)
        
        if let basicParametrs = basicParametrs {
            let basicParametrs = Row.basicInfo(parametrs: basicParametrs)
            rowsForTable.append(basicParametrs)
        }
        
        let date = Services.dateFormat(date: rocket.firstFlight) ?? rocket.firstFlight
        let firstLaunch = Row.launchInfo(info: "Первый запуск", value: date)
        rowsForTable.append(firstLaunch)
        
        let country = Row.launchInfo(info: "Страна", value: rocket.country)
        rowsForTable.append(country)
        
        let costPerLaunch  = Row.launchInfo(info: "Стоимость запуска", value: String(rocket.costPerLaunch) )
        rowsForTable.append(costPerLaunch)
        
        let firstStageInfo = Row.sectionName(title: "Первая ступень")
        rowsForTable.append(firstStageInfo)
        
        let numberOfEngines = Row.detailedInfo(info: "Количество двигателей", value: String(rocket.firstStage.engines) , measurment: nil)
        rowsForTable.append(numberOfEngines)
        
        let fuelAmountTons = Row.detailedInfo(info: "Количество топлива", value: String(rocket.firstStage.fuelAmountTons) , measurment: "ton")
        rowsForTable.append(fuelAmountTons)
        
        let burnTime = Row.detailedInfo(info: "Время сгорания", value: String(rocket.firstStage.burnTimeSec ?? 0) , measurment: "sec")
        rowsForTable.append(burnTime)
        
        let secondStageInfo = Row.sectionName(title: "Вторая ступень")
        rowsForTable.append(secondStageInfo)
        
        let numberOfEnginesInSecondStage = Row.detailedInfo(info: "Количество двигателей", value: String(rocket.secondStage.engines) , measurment: nil)
        rowsForTable.append(numberOfEnginesInSecondStage)
        
        let fuelAmountTonsInSecondStage = Row.detailedInfo(info: "Количество топлива", value: String(rocket.secondStage.fuelAmountTons) , measurment: "ton")
        rowsForTable.append(fuelAmountTonsInSecondStage)
        
        let burnTimeInSecondStage = Row.detailedInfo(info: "Время сгорания", value: String(rocket.secondStage.burnTimeSec ?? 0) , measurment: "sec")
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
                cell.buttonAction = { [unowned self] in
                    let settingsController = SettingsViewController()
                    let navController = UINavigationController(rootViewController: settingsController)
                    present(navController, animated: true)
                }
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
            navigationController?.pushViewController(LaunchViewController(), animated: true)
    }
}
 
