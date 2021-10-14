//
//  AddCityCoordinator.swift
//  MyWeather
//
//  Created by mac on 10/11/21.
//

import Foundation
import UIKit

protocol AddCityCoordinatorProtocol: class {
    func navigateToCities()
    
}

class AddCityCoordinator: Coordinator{
    
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let addCityViewController = AddCityViewController()
        let addCityViewModel = AddCityViewModel(coordinator: self)
        addCityViewController.viewModel = addCityViewModel
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(addCityViewController, animated: true)
    }
    
}

extension AddCityCoordinator: AddCityCoordinatorProtocol {
    
    func navigateToCities() {
        navigationController.popViewController(animated: true)
    }
    
}
