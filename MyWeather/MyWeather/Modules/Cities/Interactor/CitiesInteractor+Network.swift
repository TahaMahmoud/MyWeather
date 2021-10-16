//
//  CitiesInteractor+Network.swift
//  MyWeather
//
//  Created by mac on 10/13/21.
//

import Foundation
import RxSwift

protocol CitiesInteractorProtocol: class {
    
    // Network Requests
    func getWeather(cityName: String) -> Observable<HomeModel>
    // func getWeather(cityName: String) -> Observable<(HomeModel)>
    // func getWeatherWithLocation(location: String) -> Observable<(HomeModel)>

    // CoreData Requests
    func fetchCachedCities() -> Observable<[City]>
    func removeCity(cityID: Int) -> Observable<Bool>
    
    func setDefaultCity(cityID: Int) -> Observable<Bool>
}

class CitiesInteractor: CitiesInteractorProtocol {    
    
    var cachedCities: [City] = []

    var networkManager: AlamofireManager
    var coreDataManager: CoreDataManager
    
    init(networkManager: AlamofireManager) {
        self.networkManager = networkManager
        self.coreDataManager = CoreDataManager()
    }
        
    func getWeather(cityName: String) -> Observable<HomeModel> {
        return Observable.create {[weak self] (observer) -> Disposable in
            self?.networkManager.callRequest(HomeModel.self, endpoint: HomeRequest.getWeatherWithCityName(cityName: cityName)) { (result) in
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
