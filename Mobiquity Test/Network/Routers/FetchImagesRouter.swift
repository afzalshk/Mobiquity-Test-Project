//
//  FetchImagesRouter.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation

enum MTHTTPMethod: String {
    case get = "GET"
}

protocol URLRequestConvertible {
    func asURLRequest() -> URLRequest?
}

enum FetchImagesRouter: URLRequestConvertible  {
    
    case fetchImages(PhotoRequest)

    private var method: MTHTTPMethod {
        switch self {
        case .fetchImages:
            return .get
        }
    }
    
    private var queryParameters: [URLQueryItem]? {
        switch self {
        case .fetchImages(let params):
            
            return [URLQueryItem(name: "page", value: String(params.page)),
                    URLQueryItem(name: "text", value: params.searchString)]

        }
    }
    
    func asURLRequest() -> URLRequest? {
        guard let url = URL.init(string: URLS.fetchUrl) else {return nil}
        var components = URLComponents(string: url.absoluteString)
        if let queryParams =  queryParameters {
            components?.queryItems?.append(contentsOf: queryParams)
        }
        var urlRequest = URLRequest(url: (components?.url)!)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
