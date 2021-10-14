//
//  CitiesCoordinator.swift
//  MyWeather
//
//  Created by mac on 10/13/21.
//

import Foundation
import UIKit

protocol CitiesCoordinatorProtocol: class {
    func navigateToHome()
    func navigateToAddCity()
    
}

class CitiesCoordinator: Coordinator {
    
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let citiesViewController = CitiesViewController()
        let citiesViewModel = CitiesViewModel(coordinator: self)
        citiesViewController.viewModel = citiesViewModel
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(citiesViewController, animated: true)
    }
    
}

extension CitiesCoordinator: CitiesCoordinatorProtocol {
    
    func navigateToHome() {
        navigationController.popViewController(animated: true)
    }
    
    func navigateToAddCity() {
        let addCityCoordinator = AddCityCoordinator(navigationController: navigationController)
        addCityCoordinator.start()
    }

}
