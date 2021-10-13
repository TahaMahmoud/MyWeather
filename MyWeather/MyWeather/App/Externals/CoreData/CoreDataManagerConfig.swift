//
//  DataManagerConfig.swift
//  NotaApp
//
//  Created by Taha on 12/2/19.
//  Copyright © 2019 Taha. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManagerConfig {
    
    //As we know that container is set up in the AppDelegates so we need to refer that container.
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
    //We need to create a context from this container
    static let managedContext = appDelegate!.persistentContainer.viewContext
        
    //Now let’s create an entity and new user records.
    static let citiesEntity = NSEntityDescription.entity(forEntityName: "Cities", in: managedContext)!
        
}
