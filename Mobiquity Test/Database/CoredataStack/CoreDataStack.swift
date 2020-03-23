//
//  CoreDataStack.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    var managedObjectContext: NSManagedObjectContext { get {
        return self.persistentContainer.viewContext
        }
    }
    
    var workingContext: NSManagedObjectContext { get {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = self.managedObjectContext
        return context
        }
    }
        
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Mobiquity")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    private func saveContext () {
        self.managedObjectContext.performAndWait {
            if self.managedObjectContext.hasChanges {
                do {
                    try self.managedObjectContext.save()
                } catch {
                }
            }
        }
        
    }
    func saveWorkingContext(context: NSManagedObjectContext) {
        do {
            try context.save()
            saveContext()
        } catch (let error) {
            print(error)
        }
    }
    
    
}
