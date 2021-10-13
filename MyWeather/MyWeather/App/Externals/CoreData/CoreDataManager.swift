//
//  TaskDataManager.swift
//  NotaApp
//
//  Created by Taha on 12/2/19.
//  Copyright © 2019 Taha. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    var managedContext: NSManagedObjectContext
    var citiesEntity: NSEntityDescription
    
    //Prepare the request of type NSFetchRequest  for the entity
    let fetchCitiesRequest: NSFetchRequest<NSFetchRequestResult>
        
    init() {
        self.managedContext = CoreDataManagerConfig.managedContext
        self.citiesEntity = CoreDataManagerConfig.citiesEntity
        
        self.fetchCitiesRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cities")

    }
    
    func saveContext() -> Bool {
        do {
            try managedContext.save()
            return true
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
    
}
