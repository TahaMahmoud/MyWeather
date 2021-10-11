//
//  HomeInteractor+CoreData.swift
//  MyWeather
//
//  Created by mac on 10/11/21.
//

extension HomeInteractor {
    
    /*
    func getDefaultCity() -> Observable<(String)> {
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
    */

}
