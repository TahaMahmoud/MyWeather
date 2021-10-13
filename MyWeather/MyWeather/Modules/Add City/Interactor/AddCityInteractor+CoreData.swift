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
    
}
