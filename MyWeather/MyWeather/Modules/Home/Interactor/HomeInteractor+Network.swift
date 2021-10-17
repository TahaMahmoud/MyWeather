//
//  TrendingInteractor.swift
//  Popcorn
//
//  Created by mac on 16/04/2021.
//

import Foundation
import RxSwift

protocol HomeInteractorProtocol: class {
    
    // Network Requests
    func getWeatherWithCityName(cityName: String) -> Observable<(HomeModel)>
    func getWeatherWithLocation(location: String) -> Observable<(HomeModel)>

    // CoreData Requests
    func getDefaultCity() -> Observable<(String)>

}

class HomeInteractor: HomeInteractorProtocol {    
        
    var networkManager: AlamofireManager
    
    var coreDataManager: CoreDataManager
    
    init(networkManager: AlamofireManager) {
        self.networkManager = networkManager
        self.coreDataManager = CoreDataManager()
    }

    func getWeatherWithCityName(cityName: String) -> Observable<(HomeModel)> {
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
    
    func getWeatherWithLocation(location: String) -> Observable<(HomeModel)> {
        return Observable.create {[weak self] (observer) -> Disposable in
            self?.networkManager.callRequest(HomeModel.self, endpoint: HomeRequest.getWeatherWithLocation(location: location)) { (result) in
                switch result {
                case .success(let value):
                    observer.onNext(value)
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
}
