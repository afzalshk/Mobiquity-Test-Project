//
//  Constants.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation

struct APIKeys {
    static let flickerApiKey = "85e263bfc3d255c96743c112aa959de2"
}

struct URLS {
    static let fetchUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=" + APIKeys.flickerApiKey + "&format=json&nojsoncallback=1"
}
struct TimeOutInterval {
    static let requests = 20.0
    static let resources = 30.0
}

