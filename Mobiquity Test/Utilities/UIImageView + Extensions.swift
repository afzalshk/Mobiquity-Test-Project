//
//  ImageView + Extensions.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 23/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(for url :URL) {
        AppAsynImage().loadImage(for: url, in: self)
    }
}
