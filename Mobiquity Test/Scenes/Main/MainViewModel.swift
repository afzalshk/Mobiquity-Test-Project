//
//  MainViewModel.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation

typealias fetchImagesCompletion = (_ newIndexPaths: [IndexPath]?) -> Void

protocol MainViewModel {
    
    func fetchImages(searchText: String, completion: @escaping fetchImagesCompletion)
    func loadMore(completion: @escaping fetchImagesCompletion)
    func numberOfImages() -> Int
    func viewModelForImage(for indexPath: IndexPath) -> ImageCellViewModel
    func resetPage()
    func saveHistory(text: String)
}

class MainViewModelImp: MainViewModel {
    
   
    private var imagesViewModel: [ImageCellViewModel] = []
    private lazy var imageDataHandler = {return FetchImagesDataHandler()}()
    private var searchString: String?
    
}
extension MainViewModelImp {
    // MARK: - Fetching Images
    func fetchImages(searchText: String, completion: @escaping fetchImagesCompletion) {
        searchString = searchText
        imageDataHandler.getImages(for: searchText) { [weak self] (photos, resetArray, error) in
            self?.handleImageResponse(photos: photos, resetArray: resetArray, error: error, completion: completion)
        }
    }
    
    private func handleImageResponse(photos: [PhotoForCell], resetArray: Bool, error: AppError?, completion: @escaping fetchImagesCompletion) {
        
        if !photos.isEmpty {
            if resetArray {
                self.imagesViewModel.removeAll()
            }
            
            let oldSize = self.imagesViewModel.count
            
            generateImageViewModel(photos: photos)
            
            if resetArray {
                completion(nil)
            } else {
                var newIndexPaths : [IndexPath] = []
                
                for index in oldSize..<self.imagesViewModel.count {
                    newIndexPaths.append(IndexPath(item: index, section: 0))
                }
                completion(newIndexPaths)
            }
        }
        else {
            completion(nil)
        }
    }
    private func generateImageViewModel(photos: [PhotoForCell]) {
        
        for photo in photos {
            imagesViewModel.append(ImageCellViewModelImp(photo: photo))
        }
    }
    func numberOfImages() -> Int {
        return imagesViewModel.count
    }
    func viewModelForImage(for indexPath: IndexPath) -> ImageCellViewModel {
        return imagesViewModel[indexPath.item]
    }
    func loadMore(completion: @escaping fetchImagesCompletion) {
        guard let searchText = searchString else {
            completion(nil)
            return
            
        }
        if imageDataHandler.nextFeedsPage() {
            self.fetchImages(searchText: searchText, completion: completion)
        }
    }
    func resetPage() {
        imageDataHandler.resetFeedsPaging()
        imagesViewModel.removeAll()
    }
}
extension MainViewModelImp {
    ///Dependency Inversion
    // MARK: - Search History
    func saveHistory(text: String) {
       let databaseService: DataManager = CoreDataManager()
        databaseService.save(historyString: text)
    }
}

