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

    func removeCity(cityID: Int) -> Observable<Bool> {
        return Observable.create {[weak self] (observer) -> Disposable in

            (self?.coreDataManager.fetchCitiesRequest)!.predicate = NSPredicate(format: "cityID = %@", "\(cityID)")
            
             do {
                let fetchedCities = try self?.coreDataManager.managedContext.fetch((self?.coreDataManager.fetchCitiesRequest)!)
                 
                let cityToDelete = fetchedCities?[0] as! NSManagedObject
                
                self?.coreDataManager.managedContext.delete(cityToDelete)
                            
                self?.coreDataManager.saveContext()
                
                observer.onNext(true)

             }
             catch {
                print(error)
                observer.onNext(false)
             }

            return Disposables.create()
        }

    }

    func setDefaultCity(cityID: Int) -> Observable<Bool> {
        
        return Observable.create {[weak self] (observer) -> Disposable in

            do {
                // Set The Current Default City key {isDefaultCity} to false
                (self?.coreDataManager.fetchCitiesRequest)!.predicate = NSPredicate(format: "isDefaultCity = %@", true)
                var result = try self?.coreDataManager.managedContext.fetch((self?.coreDataManager.fetchCitiesRequest)!)

                if result?.count ?? 0 > 0 {
                    let oldCity = result?[0] as! NSManagedObject
                    oldCity.setValue(false, forKey: "isDefaultCity")
                }
                
                (self?.coreDataManager.fetchCitiesRequest)!.predicate = NSPredicate(format: "cityID = %@", "\(cityID)")
                result = try self?.coreDataManager.managedContext.fetch((self?.coreDataManager.fetchCitiesRequest)!)

                let newCity = result?[0] as! NSManagedObject
                newCity.setValue(true, forKey: "isDefaultCity")

                self?.coreDataManager.saveContext()

                observer.onNext(true)
                
            } catch {
                print("Error")
                observer.onNext(false)
            }
            
            return Disposables.create()
        }

    }

}
