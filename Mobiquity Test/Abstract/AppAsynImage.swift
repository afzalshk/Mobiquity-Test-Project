//
//  AppAsynImage.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

struct AppAsynImage {
    
    func loadImage(for url: URL,placeHolder: UIImage? = nil , in view:UIImageView, forceRefresh: Bool = false) {
            view.kf.indicatorType = .activity
        // This extra check is for flexibility just in case in future we need that.
            if url.isFileURL{
                let provider = LocalFileImageDataProvider(fileURL: url)
                view.kf.setImage(with: provider)
            }
            else {
                var options : KingfisherOptionsInfo? = []
                options?.append(.transition(.fade(0.2)))
                if forceRefresh{
                    view.kf.setImage(with: url, placeholder: placeHolder, options: options, progressBlock: nil) { (result) in
                    }

                    options?.append(.fromMemoryCacheOrRefresh)
                }

                view.kf.setImage(with: url, placeholder: placeHolder, options: options, progressBlock: nil) { (result) in
                }
            }
        }
}
