
//
//  LaunchesController.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 30.11.2022.
//

import UIKit

final class ViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
        
    private let networkService = NetworkService()
    private var rockets = [Rocket]()
    private var rocketViewControllers = [RocketViewController]()
    private var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        loadData()
    }
    
    private func setvc() {
        setViewControllers([rocketViewControllers[0]], direction: .forward, animated: true)
        
    }
    
    private func setPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: (view.window?.windowScene?.screen.bounds.maxY ?? 0) - 50, width: view.window?.windowScene?.screen.bounds.width ?? 100, height: 50))
        pageControl.numberOfPages = rocketViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = .black
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor  = .red
        self.view.addSubview(pageControl)
    }
    
    private func loadData() {
        DispatchQueue.global().async {
            self.networkService.getRockets { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let rockets):
                        self?.rockets = rockets
                        self?.createViewControllers()
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }

    
    private func createViewControllers() {
        for rocket in rockets {
            rocketViewControllers.append(RocketViewController(rocket: rocket))
        }
        setvc()
        setPageControl()
    }
    
    private func appendRocketViewController(rocket: Rocket, image: UIImage) {
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = rocketViewControllers.firstIndex(of: viewController as! RocketViewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        if previousIndex < 0 {
            return nil
        }
        
        if previousIndex > rocketViewControllers.count {
            return nil
        }

        return rocketViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = rocketViewControllers.firstIndex(of: viewController as! RocketViewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
    
        if nextIndex < 0 {
            return nil
        }
        
        if nextIndex == rocketViewControllers.count {
            return rocketViewControllers[0]
        }

        return rocketViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let content = pageViewController.viewControllers![0]
        self.pageControl.currentPage = rocketViewControllers.firstIndex(of: content as! RocketViewController)!
    }
    
    
}
