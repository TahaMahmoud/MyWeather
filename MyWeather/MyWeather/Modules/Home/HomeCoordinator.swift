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
    func navigateToCities()
    
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
    
    func navigateToCities() {
        let citiesCoordinator = CitiesCoordinator(navigationController: navigationController)
        citiesCoordinator.start()
    }
    
    func navigateToSettings() {
        /* let settingsCoordinator = SettingsCoordinator(navigationController: navigationController)
         settingsCoordinator.start() */
    }

}
