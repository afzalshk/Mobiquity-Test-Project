//
//  ImageCollectionViewCell.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell, DequeueInitializable {
    var viewModel: ImageCellViewModel!
    @IBOutlet weak var imageView: UIImageView!
    
    func loadImage() {
        viewModel.loadImage(for: imageView)
    }
}
