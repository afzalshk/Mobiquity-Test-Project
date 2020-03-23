//
//  NSFetchedResultsControllerHelper.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation
import CoreData

class NSFetchedResultsControllerHelper {
    static func getFetchResult(request: NSFetchRequest<NSFetchRequestResult>,context: NSManagedObjectContext,delegate: NSFetchedResultsControllerDelegate?, sectionName: String) -> NSFetchedResultsController<NSFetchRequestResult>?{
        
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: sectionName, cacheName: nil)
        controller.delegate = delegate
        do {
            try controller.performFetch()
        } catch  {
            print(error)
        }
        return controller
    }
}
