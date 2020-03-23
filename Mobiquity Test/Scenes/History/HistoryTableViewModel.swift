//
//  HistoryTableViewModel.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation
import CoreData

protocol HistoryTableViewModel {
    func numberOfSections() -> Int
    func sectionTitle(for section: Int) -> String
    func numberOfRows(for section: Int) -> Int
    func modelForHistory(for indexPath: IndexPath) -> History
}

class HistoryTableViewModelImp: HistoryTableViewModel {
    
    private let dataHandler = HistoryDataHandler()
    private var searchHistory: [HistoryInfo] = []

    init() {
       searchHistory = dataHandler.getSearchHistory() ?? []
    }
    func numberOfSections() -> Int {
        return searchHistory.count
    }
    func numberOfRows(for section: Int) -> Int {
        return searchHistory[section].numberofObjects
    }
    func modelForHistory(for indexPath: IndexPath) -> History {
        return searchHistory[indexPath.section].history[indexPath.row]
    }
    func sectionTitle(for section: Int) -> String {
        return searchHistory[section].history.first?.createdAt?.appReadableDate() ?? ""
    }
}

