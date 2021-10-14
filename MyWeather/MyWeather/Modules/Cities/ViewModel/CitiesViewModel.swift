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
    
}

class CitiesViewModel: CitiesViewModelInput, CitiesViewModelOutput {
    
    var cities: BehaviorRelay<[City]> = .init(value: [])
    var citiesWeather: BehaviorRelay<[CityDetailsCellViewModel]> = .init(value: [])

    private let coordinator: CitiesCoordinator
    let disposeBag = DisposeBag()
    
    private let citiesInteractor: CitiesInteractorProtocol
    
    init(citiesInteractor: CitiesInteractorProtocol = CitiesInteractor(networkManager: AlamofireManager()), coordinator: CitiesCoordinator) {
        self.citiesInteractor = citiesInteractor
        self.coordinator = coordinator
        
        bindCachedCities()
    }
    
    func viewDidLoad() {
        
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
        citiesInteractor.fetchCachedCities().subscribe { [weak self] (response) in
            self?.cities.accept(response.element ?? [])
            
            var cachedCities: [CityDetailsCellViewModel] = []
            
            // Get Weather for each city
            for city in self?.cities.value ?? [] {
                // Call Network
                self?.citiesInteractor.getWeather(cityName: city.cityName).subscribe { [weak self] (cityWeather) in
                    cachedCities.append(CityDetailsCellViewModel(cityID: city.cityID, cityName: city.cityName , currentTemp: cityWeather.element?.current?.tempC ?? 0, icon: "https:\(cityWeather.element?.current?.condition?.icon ?? "" )"))
                }.disposed(by: self!.disposeBag)
            }
            
            print(response)
            
            self?.citiesWeather.accept(cachedCities)
            
        }.disposed(by: disposeBag)
    }

}
