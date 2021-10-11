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
    // func getDefaultCity() -> Observable<(String)>

}

class HomeInteractor: HomeInteractorProtocol {
    
    var request: HomeRequest?
    
    func getWeatherWithCityName(cityName: String) -> Observable<(HomeModel)> {
        return Observable.create {[weak self] (observer) -> Disposable in
            self?.request = HomeRequest.getWeatherWithCityName(cityName: cityName)
            self?.request?.send(HomeModel.self, completion: { (response) in
                switch response {
                case .success(let value):
                    observer.onNext((value))
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            })
            return Disposables.create()
        }
    }
    
    func getWeatherWithLocation(location: String) -> Observable<(HomeModel)> {
        return Observable.create {[weak self] (observer) -> Disposable in
            self?.request = HomeRequest.getWeatherWithLocation(location: location)
            self?.request?.send(HomeModel.self, completion: { (response) in
                switch response {
                case .success(let value):
                    observer.onNext((value))
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            })
            return Disposables.create()
        }
    }
    
}
