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
    func hourWeatherAt(_ index: Int) -> HourData
    func hourWeatherAt(_ time: String) -> HourData
    
    func getIndexFrom(time: String) -> Int
}

protocol HomeViewModelInput {
    
    func viewDidLoad()
    func citiesPressed()
    func settingsPressed()
    
    func getWeather(latitude: String, longitude: String)
}

class HomeViewModel: HomeViewModelInput, HomeViewModelOutput {
    
    var weather: BehaviorRelay<HomeModel> = .init(value: HomeModel(location: nil, current: nil, forecast: nil))
    var days: BehaviorRelay<[DayCellViewModel]> = .init(value: [])
    
    var hours:BehaviorRelay<[HourData]> = .init(value: [])

    var currentHour: PublishSubject<HourData> = .init()
    
    var requestLocation: BehaviorRelay<Bool> = .init(value: false)

    private let coordinator: HomeCoordinator
    let disposeBag = DisposeBag()
    
    private let homeInteractor: HomeInteractorProtocol
    
    init(homeInteractor: HomeInteractorProtocol = HomeInteractor(networkManager: AlamofireManager()),coordinator: HomeCoordinator) {
        self.homeInteractor = homeInteractor
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        getWeather(latitude: "", longitude: "")
    }
            
    func citiesPressed() {
        coordinator.navigateToCities()
    }

    func settingsPressed() {
        coordinator.navigateToSettings()
    }
    
    func hourWeatherAt(_ index: Int) -> HourData {
        return hours.value[index]
    }

    func hourWeatherAt(_ time: String) -> HourData {
        
        for hour in hours.value {
            if hour.time == time {
                return hour
            }
        }
        
        return hours.value[0]
    }

    /* private func getWeather() {
        homeInteractor.getWeather().subscribe{ (response) in
            self.weather.accept(response)
            // print(response)
        }.disposed(by: disposeBag)
    } */
        
    func getWeather(latitude: String, longitude: String) {
        
        // Fetch Default City
        homeInteractor.getDefaultCity().subscribe { [weak self] (defaultCity) in
                              
            if defaultCity.element != "" || ( latitude != "" && longitude != "" ) {
                
                if defaultCity.element != "" {
                    // Get Weather of Default City
                    self?.homeInteractor.getWeatherWithCityName(cityName: defaultCity.element ?? "").subscribe { [weak self] (response) in
                        self?.weather.accept(response.element ?? HomeModel(location: nil, current: nil, forecast: nil))
                        
                        let forecastDays = self?.weather.value.forecast?.forecastday
                        var responseDays: [DayCellViewModel] = []
                        
                        var responseHours: [HourData] = []

                        let currentDay = self?.weather.value.forecast?.forecastday?[0]
                        
                        for day in forecastDays ?? [] {
                            responseDays.append(DayCellViewModel(dayName: self!.getDayNameBy(stringDate: day.date ?? "" ), temp: day.day?.avgtempC ?? 0, icon: "https:\(day.day?.condition?.icon ?? "")"))
                        }
                           
                        // Get hours of first Day
                        for hour in (currentDay?.hour) ?? [] {
                            
                            // Get Hour Part Only
                            responseHours.append((self!.getTimeFrom(date: hour.time ?? ""), hour.tempC ?? 0, hour.condition?.text ?? "", "https:\(hour.condition?.icon ?? "")" ))
                        }
                        
                        // print(self.hours)
                        self?.days.accept(responseDays)
                        self?.hours.accept(responseHours)
                        
                        self?.getCurrentHour()

                    }.disposed(by: self!.disposeBag)
                }
                else {
                    // Get Weather With Location
                    let location = latitude + "," + longitude
                        
                    self?.homeInteractor.getWeatherWithLocation(location: location).subscribe { [weak self] (response) in
                        self?.weather.accept(response.element ?? HomeModel(location: nil, current: nil, forecast: nil))
                        
                        let forecastDays = self?.weather.value.forecast?.forecastday
                        var responseDays: [DayCellViewModel] = []
                        
                        var responseHours: [HourData] = []

                        let currentDay = self?.weather.value.forecast?.forecastday?[0]
                        
                        for day in forecastDays ?? [] {
                            responseDays.append(DayCellViewModel(dayName: self!.getDayNameBy(stringDate: day.date ?? "" ), temp: day.day?.avgtempC ?? 0, icon: "https:\(day.day?.condition?.icon ?? "")"))
                        }
                           
                        // Get hours of first Day
                        for hour in (currentDay?.hour) ?? [] {
                            
                            // Get Hour Part Only
                            responseHours.append((self!.getTimeFrom(date: hour.time ?? ""), hour.tempC ?? 0, hour.condition?.text ?? "", "https:\(hour.condition?.icon ?? "")" ))
                        }
                        
                        // print(self.hours)
                        self?.days.accept(responseDays)
                        self?.hours.accept(responseHours)
                        
                        self?.getCurrentHour()
                    }.disposed(by: self!.disposeBag)

                }
            }
            else {
                // No Default City, No Location Exist
                // Request Location
                self?.requestLocation.accept(true)
            }
            
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

    func getTimeFrom(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //this your string date format
        let convertedDate = dateFormatter.date(from: date)

        dateFormatter.dateFormat = "h:mm a" // This is what you want to convert format
        let timeStamp = dateFormatter.string(from: convertedDate!)

        return timeStamp
    }
    
    func getCurrentHour() {

        let formatter = DateFormatter()
        formatter.dateFormat = "h:00 a"

        let time = formatter.string(from: Date())

        for hour in hours.value {
            if hour.time == time {
                currentHour.onNext(hour)
            }
        }
    }
    
    func getIndexFrom(time: String) -> Int {
        var index = 0
        
        for hour in hours.value {
            if hour.time == time {
                return index
            }
            else {
                index = index + 1
            }
        }
        
        return index
    }

}
