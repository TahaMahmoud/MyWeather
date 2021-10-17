//
//  CitiesViewModel.swift
//  MyWeather
//
//  Created by mac on 10/13/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol CitiesViewModelOutput {
    func cityViewModelAtIndexPath(_ indexPath: IndexPath) -> CityDetailsCellViewModel
}

protocol CitiesViewModelInput {
    
    func viewDidLoad()
    func addCityPressed()
    func backPressed()
    
    func removeCity(indexPath: IndexPath)
    func setDefaultCity(indexPath: IndexPath)

}

class CitiesViewModel: CitiesViewModelInput, CitiesViewModelOutput {
    
    // var cities: BehaviorRelay<[City]> = .init(value: [])
    var citiesWeather: BehaviorRelay<[CityDetailsCellViewModel]> = .init(value: [])

    var defaultCityID = 0
    
    private let coordinator: CitiesCoordinator
    let disposeBag = DisposeBag()
    
    private let citiesInteractor: CitiesInteractorProtocol
    
    init(citiesInteractor: CitiesInteractorProtocol = CitiesInteractor(networkManager: AlamofireManager()), coordinator: CitiesCoordinator) {
        self.citiesInteractor = citiesInteractor
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        bindCachedCities()
    }
    
    func addCityPressed() {
        coordinator.navigateToAddCity()
    }

    func backPressed() {
        coordinator.navigateToHome()
    }
    
    func cityViewModelAtIndexPath(_ indexPath: IndexPath) -> CityDetailsCellViewModel {
        return citiesWeather.value[indexPath.row]
    }
    
    func bindCachedCities() {
        var cachedCities: [CityDetailsCellViewModel] = []
        
        // Remove Old Data
        var array = citiesWeather.value
        array.removeAll()
        citiesWeather.accept(array)

        citiesInteractor.fetchCachedCities().subscribe { [weak self] (response) in
            // achedCities.removeAll()

            // Get Weather for each city
            for city in response.element ?? [] {
                self!.citiesInteractor.getWeather(cityName: city.cityName).subscribe { [weak self] (weatherResponse) in
                    cachedCities.append(CityDetailsCellViewModel(cityID: city.cityID, cityName: city.cityName , currentTemp: weatherResponse.element?.current?.tempC ?? 0, icon: "https:\(weatherResponse.element?.current?.condition?.icon ?? "" )"))
                    
                    if city.isDefaultCity {
                        print("Current Default City " + city.cityName)
                        self?.defaultCityID = city.cityID
                    }

                    self?.citiesWeather.accept(cachedCities)
                    
                }.disposed(by: self!.disposeBag)
            }
        
        }.disposed(by: disposeBag)
    }
    
    func removeCity(indexPath: IndexPath) {
        
        var cities = self.citiesWeather.value

        let removedCityID = cities[indexPath.row].cityID
    
        citiesInteractor.removeCity(cityID: removedCityID).subscribe { [weak self] (response) in
            if response.element ?? false {
                
                // Check if the removed city is the default city to re-select new default city
                if removedCityID == self?.defaultCityID {
                    
                    // Select first city to be default city
                    let newCityIndexPath = IndexPath(row: indexPath.row + 1 , section: 0)
                    print("New Default City " + cities[newCityIndexPath.row].cityName)
                    self?.setDefaultCity(indexPath: newCityIndexPath)
                }
                
                // Remove City from Data Source
                cities.remove(at: indexPath.row)
                
                self?.citiesWeather.accept(cities)

            }
            else {
                print(response.error)
            }
        }.disposed(by: disposeBag)
    }

    func setDefaultCity(indexPath: IndexPath) {
        
        let cities = self.citiesWeather.value
        let newDefaultCityID = cities[indexPath.row].cityID

        citiesInteractor.setDefaultCity(cityID: newDefaultCityID).subscribe { (response) in
            if response.element ?? false {
                // Remove City from Data Source
                print("Default City Changed")
            }
            else {
                print(response.error)
            }
        }.disposed(by: disposeBag)
    }

}
