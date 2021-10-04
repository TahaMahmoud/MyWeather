//
//  OnBoardingCoordinator.swift
//  MyWeather
//
//  Created by mac on 9/27/21.
//

import Foundation
import UIKit

protocol OnBoardingCoordinatorProtocol: class {
    func navigateToHome()
}

class OnBoardingCoordinator: Coordinator{
    
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let onBoardingViewController = OnBoardingViewController()
        let onBoardingViewModel = OnBoardingViewModel(coordinator: self)
        onBoardingViewController.viewModel = onBoardingViewModel
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(onBoardingViewController, animated: true)
    }
    
}

extension OnBoardingCoordinator: OnBoardingCoordinatorProtocol {
    
    func navigateToHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
    
}
