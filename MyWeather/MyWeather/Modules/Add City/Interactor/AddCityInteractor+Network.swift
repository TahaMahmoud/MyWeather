//
//  AddCityInteractor+Network.swift
//  MyWeather
//
//  Created by mac on 10/11/21.
//

import Foundation
import RxSwift

protocol AddCityInteractorProtocol: class {
    
    // Network Requests
    func featchCities(cityName: String) -> Observable<[CityModel]>
    // func getWeatherWithLocation(location: String) -> Observable<(HomeModel)>

    // CoreData Requests
    func checkCityExist(cityName: String) -> Observable<Bool>
    func addNewCity(city: City) -> Observable<Bool>
    func fetchLastCity() -> Observable<City>

}

class AddCityInteractor: AddCityInteractorProtocol {
    
    var networkManager: AlamofireManager
    var coreDataManager: CoreDataManager
    
    init(networkManager: AlamofireManager) {
        self.networkManager = networkManager
        self.coreDataManager = CoreDataManager()
    }
    
    func featchCities(cityName: String) -> Observable<[CityModel]> {
        return Observable.create {[weak self] (observer) -> Disposable in
            self?.networkManager.callRequest([CityModel].self, endpoint: AddCityRequest.fetchCities(cityName: cityName)) { (result) in
                switch result {
                case .success(let value):
                    observer.onNext((value))
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }

}
