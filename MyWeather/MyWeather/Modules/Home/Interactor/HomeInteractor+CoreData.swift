//
//  HomeInteractor+CoreData.swift
//  MyWeather
//
//  Created by mac on 10/11/21.
//

import RxSwift
import CoreData

extension HomeInteractor {
    
    func getDefaultCity() -> Observable<(String)> {
        
        var currentDefaultCityName = ""
        
        return Observable.create {[weak self] (observer) -> Disposable in

            do {
                // Set The Current Default City key {isDefaultCity} to false
                let result = try self?.coreDataManager.managedContext.fetch((self?.coreDataManager.fetchCitiesRequest)!)

                for city in result as? [NSManagedObject] ?? [] {
                
                    if city.value(forKey: "isDefaultCity") as? Bool ?? false {
                        currentDefaultCityName = city.value(forKey: "cityName") as! String
                    }
                    
                }
                                
                observer.onNext(currentDefaultCityName)
                
            } catch {
                print("Error")
                observer.onNext("")
            }
            
            return Disposables.create()
        }

    }

}
