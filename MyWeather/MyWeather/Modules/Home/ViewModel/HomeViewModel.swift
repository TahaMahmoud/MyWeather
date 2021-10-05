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
    func daysViewModelAtIndexPath(_ indexPath: IndexPath) -> DayCellViewModel
}

protocol HomeViewModelInput {
    
    func viewDidLoad()
    func addCityPressed()
    func settingsPressed()
    
}

class HomeViewModel: HomeViewModelInput, HomeViewModelOutput {
    
    var hours: [String] = []
    var weather: BehaviorRelay<HomeModel> = .init(value: HomeModel(location: nil, current: nil, forecast: nil))
    var days: BehaviorRelay<[DayCellViewModel]> = .init(value: [])

    private let coordinator: HomeCoordinator
    let disposeBag = DisposeBag()
    
    private let homeInteractor: HomeInteractorProtocol
    
    init(homeInteractor:HomeInteractorProtocol = HomeInteractor(),coordinator: HomeCoordinator) {
        self.homeInteractor = homeInteractor
        self.coordinator = coordinator
        fillHoursData()
        getWeather()
        bindWeatherDays()
    }
    
    func viewDidLoad() {
        
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
        
    private func getWeather() {
        homeInteractor.getWeather().subscribe{ (response) in
            self.weather.accept(response)
            // print(response)
        }.disposed(by: disposeBag)
    }
    
    func bindWeatherDays() {
        homeInteractor.getWeather().subscribe { (response) in
            let forecastDays = response.element?.forecast?.forecastday
            var responseDays: [DayCellViewModel] = []
        
            for day in forecastDays! {
                responseDays.append(DayCellViewModel(dayName: self.getDayNameBy(stringDate: day.date ?? "" ), temp: day.day?.avgtempC ?? 0, icon: "https:\(day.day?.condition?.icon ?? "")"))
            }
            
            self.days.accept(responseDays)
            
        }.disposed(by: disposeBag)
    }
    
    func daysViewModelAtIndexPath(_ indexPath: IndexPath) -> DayCellViewModel {
        return days.value[indexPath.row]
    }

    func getDayNameBy(stringDate: String) -> String {
        let df  = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        let date = df.date(from: stringDate)!
        df.dateFormat = "EEEE"
        return df.string(from: date);
    }

}
