//
//  FetchImagesService.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation

typealias FetchImageCompletionBlock = (Result<Photos?,AppError>) -> Void
protocol FetchImagesService {
     func fetchAlbum(for page: Int, searchText: String, completion: @escaping FetchImageCompletionBlock)
}
class FetchImagesServiceImp {
    private let apiConvertible = APIClient()
    private func fetchAlbumImp(for page: Int, searchText: String, completion: @escaping FetchImageCompletionBlock) {
        
        let request = PhotoRequest(page: page, searchString: searchText)
        let router = FetchImagesRouter.fetchImages(request)
        apiConvertible.performRequest(router: router) { (result:Result<PhotosResponse, AppError>) in
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if data.stat == "ok" {
                    completion(.success(data.photos))
                }
                else {
                     completion(.failure(AppError(error: "Something went wrong")))
                }
                
            }
        }
    }
}
extension FetchImagesServiceImp: FetchImagesService {
    func fetchAlbum(for page: Int, searchText: String, completion: @escaping FetchImageCompletionBlock) {
        self.fetchAlbumImp(for: page, searchText: searchText, completion: completion)
    }
}
