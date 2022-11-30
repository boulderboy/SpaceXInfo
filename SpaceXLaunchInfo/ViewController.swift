
//
//  LaunchesController.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 30.11.2022.
//

import UIKit

final class LaunchesViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource {
    
    private let networkService = NetworkService()
    private var launches: [Launch]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    private func loadData() {
        DispatchQueue.global().async {
            self.networkService.getLaunches { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let launches):
                        self?.launches = launches
                        print(launches)
                    case .failure(let error):
                        print(error)
                    }
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        launches?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
