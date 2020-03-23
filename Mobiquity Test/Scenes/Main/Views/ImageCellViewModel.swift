//
//  ImageCellViewModel.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation
import UIKit

protocol ImageCellViewModel {
    func loadImage(for imageView :UIImageView)
}
class ImageCellViewModelImp: ImageCellViewModel {

    let photo: PhotoForCell
    
    init(photo: PhotoForCell) {
        self.photo = photo
    }
    
    private func returnImageUrl() -> URL? {
        let imageUrl = "http://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.photoID)_\(photo.secret).jpg"
        return URL(string: imageUrl)
    }
    func loadImage(for imageView :UIImageView){
        if let url = returnImageUrl() {
            imageView.loadImage(for: url)
        }
    }
    
}
