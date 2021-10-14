//
//  AddCityInteractor+CoreData.swift
//  MyWeather
//
//  Created by mac on 10/11/21.
//

import Foundation
import RxSwift
import CoreData

extension AddCityInteractor {
    
    func addNewCity(city: City) -> Observable<Bool> {
        
        let cityID: Int = city.cityID
        let cityName: String = city.cityName
        let isDefaultCity: Bool = city.isDefaultCity
        
        let city = NSManagedObject(entity: coreDataManager.citiesEntity, insertInto: coreDataManager.managedContext)

        city.setValue(cityID, forKey: "cityID")
        city.setValue(cityName, forKey: "cityName")
        city.setValue(isDefaultCity, forKey: "isDefaultCity")

        return Observable.create {[weak self] (observer) -> Disposable in
            if self?.coreDataManager.saveContext() == true {
                observer.onNext(true)
            }
            else {
                observer.onNext(false)
            }
            
            return Disposables.create()
        }
        
    }
    
    func fetchLastCity() -> Observable<City> {
        return Observable.create {[weak self] (observer) -> Disposable in

            do {

                let result = try self?.coreDataManager.managedContext.fetch((self?.coreDataManager.fetchCitiesRequest)!)
                var lastCity: City = City(cityID: 0, cityName: "", isDefaultCity: false)
                
                if result?.count ?? 0 > 0 {
                    let lastCityResult = result?.last as! NSManagedObject
                    
                    let cityID: Int = lastCityResult.value(forKey: "cityID") as! Int
                    let cityName: String = lastCityResult.value(forKey: "cityName") as! String
                    let isDefaultCity: Bool = lastCityResult.value(forKey: "isDefaultCity") as! Bool
                    
                    lastCity = City(cityID: cityID, cityName: cityName, isDefaultCity: isDefaultCity)

                }
                
                observer.onNext(lastCity)

            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
            
    }

}
