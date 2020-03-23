//
//  Date + Extensions.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func appReadableDate() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy hh:mm aaa"
        return formatter.string(from: self)
    }
}
