//
//  HistoryDataHandler.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation
import CoreData

protocol HistoryDataHandlerDelegate: AnyObject {
      func searchHistoryUpdated()
}
class HistoryDataHandler: NSObject {
    
    private var historyFetchController: NSFetchedResultsController<NSFetchRequestResult>?
    weak var delegate: HistoryDataHandlerDelegate?
    private let context = CoreDataStack.shared.managedObjectContext
    
    override init() {
        super.init()
        let historyHandler = HistoryEntityHandler()
        let historyRequest = historyHandler.fetchRequest()
        historyRequest?.sortDescriptors = historyHandler.sortDescriptor()
        if historyRequest != nil {
            historyFetchController = NSFetchedResultsControllerHelper.getFetchResult(request: historyRequest!, context: context, delegate: self, sectionName: "createdAt")
        }
    }
    
    func getSearchHistory() -> Array<HistoryInfo>? {
        do {
            try historyFetchController?.performFetch()
        } catch {
            print("error while fetching items:", error)
            
        }
        var historyInfo: [HistoryInfo] = []
        if let sections = historyFetchController?.sections, sections.count > 0 {
            for info in sections {
                let history = HistoryInfo(numberofObjects: info.numberOfObjects, history: (info.objects as? [History] ?? []))
                historyInfo.append(history)
            }
        }
        
        return historyInfo
    }
}
extension HistoryDataHandler: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
          // MARK: - Can be used to get update
            delegate?.searchHistoryUpdated()
    }
}
