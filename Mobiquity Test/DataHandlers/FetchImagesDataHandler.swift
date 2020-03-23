//
//  FetchImagesDataHandler.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation
typealias FetchImagesDataHandlerCompletionBlock = (_ artists: [Photo],_ resetArray: Bool,_ error: AppError?) -> Void
class FetchImagesDataHandler: NSObject {
    
    private let service: FetchImagesService = FetchImagesServiceImp()
    
    private var page = 1
    private var isLoading = false
    private var isNextPageAvailable = true
        
    func resetFeedsPaging() {
        self.isNextPageAvailable = true
        self.page = 1
    }
    
    func nextFeedsPage() -> Bool {
        if isNextPageAvailable && !isLoading{
            self.page = self.page + 1
            return true
        }
        return false
    }
    
    private func currentPageError () {
        self.page = self.page - 1
        if self.page < 1 {
            self.page = 1
        }
    }
   fileprivate func feedLoading(feedloading: Bool)  {
         isLoading = feedloading
    }
    fileprivate func currentPageNumber() -> Int {
        return page
    }
    
    func getImages(for searchText:String, completion: @escaping FetchImagesDataHandlerCompletionBlock) {
        getImagesLogic(for: searchText, completion: completion)
    }
    
    private func getImagesLogic(for searchText:String, completion: @escaping FetchImagesDataHandlerCompletionBlock) {
        isLoading = true
        service.fetchAlbum(for: page, searchText: searchText) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .failure(let error):
                self.isNextPageAvailable = true
                self.isLoading = false
                completion([],false,error)
            case .success(let photos):
                self.isLoading = false
                guard let data = photos else{
                    completion([],false,nil)
                    return}
                self.page = data.page + 1
                self.isNextPageAvailable = data.page < data.pages
                completion(data.photo,data.page == 1, nil)
                
            }
        }
    }
    
}
