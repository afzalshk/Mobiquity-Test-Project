//
//  DataManager.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 23/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation

//MARK: - DataManager Protocol

protocol DataManager {
    func save(historyString: String)
}

/// Dependency Inversion
class CoreDataManager: DataManager {
    
     private lazy var workingContext = {CoreDataStack.shared.workingContext}()
    
    func save(historyString: String) {
        HistoryEntityHandler().create(wiht: historyString, context: workingContext)
        CoreDataStack.shared.saveWorkingContext(context: workingContext)
    }
}
