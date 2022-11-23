//
//  ViewController.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 22.11.2022.
//

import UIKit

final class ViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var rocketVeiwControllers = [UIViewController]()
    let pageControl = UIPageControl()
    let networkService = NetworkService()
    var rockets = [Rocket]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        rocketVeiwControllers = [
                {
                    let vc = RocketViewController()
                    vc.view.backgroundColor = .red
                    return vc
                }(),
                {
                    let vc = RocketViewController()
                    vc.view.backgroundColor = .green
                    return vc
                }(),
                {
                    let vc = RocketViewController()
                    vc.view.backgroundColor = .blue
                    return vc
                }()
            ]
        
        
        networkService.getRockets { result in
            switch result {
            case .success(let result):
                self.rockets = result
                print(self.rockets[0].name)
            case .failure(let error):
                print(error)
            }
        }
        
        view.addSubview(pageControl)
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        appearance.pageIndicatorTintColor = UIColor.black
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.numberOfPages = rocketVeiwControllers.count
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            pageControl.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ])
        setViewControllers([rocketVeiwControllers[2]], direction: .forward, animated: true)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = rocketVeiwControllers.firstIndex(of: viewController) else { return nil}
        if index == 0 {
            return rocketVeiwControllers.last
        } else {
            return rocketVeiwControllers[index - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = rocketVeiwControllers.firstIndex(of: viewController) else { return nil}
        if index == rocketVeiwControllers.count - 1 {
            return rocketVeiwControllers.first
        } else {
            return rocketVeiwControllers[index + 1]
        }

    }
    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        currentIndex
//    }
//
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        rocketVeiwControllers.count
//    }
}

