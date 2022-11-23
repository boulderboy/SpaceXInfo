//
//  ViewController.swift
//  SpaceXLaunchInfo
//
//  Created by Mac on 22.11.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    let networkService = NetworkService()
    var rockets = [Rocket]()
    var rocketImage = UIImage()
    
    let rocketBackgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let infoView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        view.addSubview(rocketBackgroundImage)
        view.addSubview(infoView)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.backgroundColor = .brown
        infoView.layer.cornerRadius = 32
        
        NSLayoutConstraint.activate([
            rocketBackgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            rocketBackgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rocketBackgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rocketBackgroundImage.heightAnchor.constraint(equalToConstant: 500),
            infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.heightAnchor.constraint(equalToConstant: 564)
        ])
        
        loadData()
    }
    
    private func setInfo() {
        rocketBackgroundImage.image = rocketImage
        print(rocketImage.size)
    }
    
    private func fetchInfo() {
        let image = networkService.loadImages(for: rockets[0].flickrImages) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                self.rocketImage = image
                DispatchQueue.main.async {
                    self.setInfo()
                }
            }
        }
        
    }
    
    private func loadData() {
        DispatchQueue.global().async {
            self.networkService.getRockets { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let rockets):
                        self?.rockets = rockets
                        self?.fetchInfo()
                                        
                    case .failure(let error):
                        print(error)
                    }
                }
                
            }
        }
    }
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    var rocketVeiwControllers = [UIViewController]()
//    let pageControl = UIPageControl()
//    let networkService = NetworkService()
//    var rockets = [Rocket]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.delegate = self
//        self.dataSource = self
//        rocketVeiwControllers = [
//                {
//                    let vc = RocketViewController()
//                    vc.view.backgroundColor = .red
//                    return vc
//                }(),
//                {
//                    let vc = RocketViewController()
//                    vc.view.backgroundColor = .green
//                    return vc
//                }(),
//                {
//                    let vc = RocketViewController()
//                    vc.view.backgroundColor = .blue
//                    return vc
//                }()
//            ]
//
//
//        networkService.getRockets { result in
//            switch result {
//            case .success(let result):
//                self.rockets = result
//                print(self.rockets[0].name)
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//        view.addSubview(pageControl)
//        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
//        appearance.pageIndicatorTintColor = UIColor.black
//        appearance.currentPageIndicatorTintColor = UIColor.white
//        appearance.numberOfPages = rocketVeiwControllers.count
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            pageControl.heightAnchor.constraint(equalToConstant: 50),
//            pageControl.widthAnchor.constraint(equalToConstant: view.bounds.width)
//        ])
//        setViewControllers([rocketVeiwControllers[2]], direction: .forward, animated: true)
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let index = rocketVeiwControllers.firstIndex(of: viewController) else { return nil}
//        if index == 0 {
//            return rocketVeiwControllers.last
//        } else {
//            return rocketVeiwControllers[index - 1]
//        }
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let index = rocketVeiwControllers.firstIndex(of: viewController) else { return nil}
//        if index == rocketVeiwControllers.count - 1 {
//            return rocketVeiwControllers.first
//        } else {
//            return rocketVeiwControllers[index + 1]
//        }
//
//    }
//
////    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
////        currentIndex
////    }
////
////    func presentationCount(for pageViewController: UIPageViewController) -> Int {
////        rocketVeiwControllers.count
////    }

