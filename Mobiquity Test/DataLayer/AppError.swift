//
//  AppError.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation

struct AppError: Codable,Error {
    let error : String
    static func generalError() -> AppError{
        return AppError(error: "some thing went wrong")
    }
}

extension AppError {
    private enum CodingKeys: String, CodingKey {
        case error = "Error"
    }
}
