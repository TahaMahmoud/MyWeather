//
//  HomeViewModel.swift
//  MyWeather
//
//  Created by mac on 10/4/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelOutput {
    
}

protocol HomeViewModelInput {
    
    func viewDidLoad()
    func addCityPressed()
    func settingsPressed()
    
}

class HomeViewModel: HomeViewModelInput, HomeViewModelOutput {
    
    var hours: [String] = []

    private let coordinator: HomeCoordinator
    let disposeBag = DisposeBag()
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func viewDidLoad(){
        fillHoursData()
    }
            
    func addCityPressed() {
        coordinator.navigateToAddCity()
    }

    func settingsPressed() {
        coordinator.navigateToSettings()
    }

    func fillHoursData() {
        for hour in 1...12 {
            hours.append("\(hour):00 AM")
        }
        
        for hour in 1...11 {
            hours.append("\(hour):00 PM")
        }
    }
    
}
