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
    var cities: BehaviorRelay<[CityCellViewModel]> { get set }

    func cityViewModelAtIndexPath(_ indexPath: IndexPath) -> CityCellViewModel

    var successMessage: PublishSubject<String> { get set }
    var errorMessage: PublishSubject<String> { get set }

}

protocol AddCityViewModelInput {
    
    func viewDidLoad()
    
    func backToCities()
    
    func fetchCities(cityName: String)
    func addCity(cityName: String)
}

class AddCityViewModel: AddCityViewModelInput, AddCityViewModelOutput {
    
    var cities: BehaviorRelay<[CityCellViewModel]> = .init(value: [])
    
    var successMessage: PublishSubject<String> = .init()
    var errorMessage: PublishSubject<String> = .init()

    private let coordinator: AddCityCoordinator
    let disposeBag = DisposeBag()
    
    private let addCityInteractor: AddCityInteractorProtocol
    
    init(addCityInteractor: AddCityInteractorProtocol = AddCityInteractor(networkManager: AlamofireManager()), coordinator: AddCityCoordinator) {
        self.addCityInteractor = addCityInteractor
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        
    }
    
    func fetchCities(cityName: String) {
        
        addCityInteractor.featchCities(cityName: cityName).subscribe { (response) in
            
            // Remove Old Data
            var array = self.cities.value
            array.removeAll()
            self.cities.accept(array)

            let responseCities = response.element
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

    func addCity(cityName: String) {
        
        var lastCityID = 0
        
        // Fetch last city id to create city with new id
        addCityInteractor.fetchLastCity().subscribe { [weak self] (response) in
            lastCityID = response.element?.cityID ?? 0
            
            let newCity = City(cityID: lastCityID + 1, cityName: cityName, isDefaultCity: false)
            
            self?.addCityInteractor.addNewCity(city: newCity).subscribe { [weak self] (addCityResponse) in
                if addCityResponse.element ?? false {
                    self?.successMessage.onNext("City Added Successfully")
                }
                else {
                    self?.errorMessage.onNext("Something Went Wrong")
                }
            }.disposed(by: self!.disposeBag)
            
        }.disposed(by: disposeBag)
        
    }

    func backToCities() {
        coordinator.navigateToCities()
    }

}
