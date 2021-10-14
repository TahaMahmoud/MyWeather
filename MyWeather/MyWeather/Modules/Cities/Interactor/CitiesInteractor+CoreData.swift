//
//  CitiesInteractor+CoreData.swift
//  MyWeather
//
//  Created by mac on 10/13/21.
//

import Foundation
import RxSwift
import CoreData

extension CitiesInteractor {
    
    func fetchCachedCities() -> Observable<[City]> {
        return Observable.create {[weak self] (observer) -> Disposable in

            do {

                let result = try self?.coreDataManager.managedContext.fetch((self?.coreDataManager.fetchCitiesRequest)!)
                
                for citiesData in result as! [NSManagedObject] {
                    
                    let cityID: Int = citiesData.value(forKey: "cityID") as! Int
                    let cityName: String = citiesData.value(forKey: "cityName") as! String
                    let isDefaultCity: Bool = citiesData.value(forKey: "isDefaultCity") as! Bool
                    
                    self?.cachedCities.append(City(cityID: cityID, cityName: cityName, isDefaultCity: isDefaultCity))
                                    
                }
                                
                observer.onNext(self!.cachedCities)
                
            } catch {
                print("Error")
                observer.onNext([])
            }
            
            return Disposables.create()
        }
            
    }

}
