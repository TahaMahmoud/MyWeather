//
//  TrendingInteractor.swift
//  Popcorn
//
//  Created by Ramzy on 16/04/2021.
//

import Foundation
import RxSwift

protocol HomeInteractorProtocol: class {
    func getWeather() -> Observable<(HomeModel)>
}

class HomeInteractor:HomeInteractorProtocol {
    var request: HomeRequest?
    
    func getWeather() -> Observable<(HomeModel)> {
        return Observable.create {[weak self] (observer) -> Disposable in
            self?.request = HomeRequest.getWeather
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
