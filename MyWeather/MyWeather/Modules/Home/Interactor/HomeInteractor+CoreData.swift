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
                //(self?.coreDataManager.fetchCitiesRequest)!.predicate = NSPredicate(format: "isDefaultCity = %@", true)
                let result = try self?.coreDataManager.managedContext.fetch((self?.coreDataManager.fetchCitiesRequest)!)

                if result?.count ?? 0 > 0 {
                    currentDefaultCityName = (result?[0] as! NSManagedObject).value(forKey: "cityName") as! String
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
