//
//  HomeCoordinator.swift
//  MyWeather
//
//  Created by mac on 10/4/21.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol: class {
    func navigateToSettings()
    func navigateToAddCity()
    
}

class HomeCoordinator: Coordinator{
    
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController = HomeViewController()
        let homeViewModel = HomeViewModel(coordinator: self)
        homeViewController.viewModel = homeViewModel
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    
    func navigateToSettings() {
        print("Navigated To Settings")
    }
    
    func navigateToAddCity() {
        let addCityCoordinator = AddCityCoordinator(navigationController: navigationController)
        addCityCoordinator.start()
    }

}
