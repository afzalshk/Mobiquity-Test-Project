//
//  History+CoreDataProperties.swift
//  
//
//  Created by Afzal Murtaza on 22/03/2020.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var searchText: String?

}
