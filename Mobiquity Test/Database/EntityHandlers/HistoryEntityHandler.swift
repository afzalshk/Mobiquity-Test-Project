//
//  HistoryEntityHandler.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation
import CoreData

class HistoryEntityHandler: NSObject {
    
    func fetchRequest() -> NSFetchRequest<NSFetchRequestResult>? {
        return History.fetchRequest()
    }
    func sortDescriptor() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "createdAt", ascending: false)]
    }
    
    func create(wiht text: String?, context: NSManagedObjectContext){
        guard let searchText = text  else {return}
        var userHistory: History!
        if let history = self.withSearchText(searchText: searchText, context: context) {
            userHistory = history
        }
        else {
            userHistory = History(entity: History.entity(), insertInto: context)
        }
        userHistory.searchText = text
        userHistory.createdAt = Date()
    }
    func withSearchText(searchText: String, context: NSManagedObjectContext) -> History?  {
        let fetchRequest = self.fetchRequest()
        fetchRequest?.predicate = NSPredicate(format: "searchText = %@", searchText)
        
        do {
            let fetchedObject = try context.fetch(fetchRequest!)
            if let fetchedObject = fetchedObject  as? [History], fetchedObject.count > 0 {
                return fetchedObject.first
            }
            return nil
        } catch {
            return nil
        }
    }
    
}
