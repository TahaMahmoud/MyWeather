//
//  AddCityViewModel.swift
//  MyWeather
//
//  Created by mac on 10/11/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol AddCityViewModelOutput {
    func cityViewModelAtIndexPath(_ indexPath: IndexPath) -> CityCellViewModel

}

protocol AddCityViewModelInput {
    
    func viewDidLoad()
    
    func fetchCities(cityName: String)
}

class AddCityViewModel: AddCityViewModelInput, AddCityViewModelOutput {
    
    var citiesResult: BehaviorRelay<CityModel> = .init(value: CityModel(cities: []))
    var cities: BehaviorRelay<[CityCellViewModel]> = .init(value: [])
    
    private let coordinator: AddCityCoordinator
    let disposeBag = DisposeBag()
    
    private let addCityInteractor: AddCityInteractorProtocol
    
    init(addCityInteractor: AddCityInteractorProtocol = AddCityInteractor(), coordinator: AddCityCoordinator) {
        self.addCityInteractor = addCityInteractor
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        
    }
    
    func fetchCities(cityName: String) {
        addCityInteractor.featchCities(cityName: cityName).subscribe { (response) in
            
            let responseCities = response.element?.cities
            var cities: [CityCellViewModel] = []
                        
            for city in responseCities ?? [] {
                cities.append(CityCellViewModel(cityName: city.name ?? ""))
            }
            
            self.cities.accept(cities)
            
        }.disposed(by: disposeBag)
    }
            
    func cityViewModelAtIndexPath(_ indexPath: IndexPath) -> CityCellViewModel {
        return cities.value[indexPath.row]
    }

}
