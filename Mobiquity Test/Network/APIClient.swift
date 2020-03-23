//
//  APIClient.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 22/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import Foundation

protocol ApiService {
    func performRequest<T:Decodable>(router: URLRequestConvertible, completionHandler: @escaping (Result<T,AppError>) -> Void)
}

struct APIClient {
    
    private let session = URLSession(configuration: .default)
    
    private func perform(request : URLRequest?, completion:@escaping (Result<Data,AppError>) -> Void) {
        
        guard let url = request?.url else {
            let error = AppError.init(error: "Url is n't valid")
            completion(.failure(error))
            return
        }
        
        let task = session.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let data = data {
                
                completion(.success(data))
                
            } else if let error = error {
                
                completion(.failure(AppError.init(error: error.localizedDescription)))
            }
        }
        
        task.resume()
    }
}
extension APIClient:ApiService {
     func performRequest<T:Decodable>(router: URLRequestConvertible, completionHandler: @escaping (Result<T,AppError>) -> Void) {
        
        self.perform(request: router.asURLRequest()) { result in
            
            switch result {
            case .success(let data):
                do {
                    
                    let decode = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(decode))
                    
                }catch let error {
                    
                    completionHandler(.failure(AppError(error:error.localizedDescription)))
                    
                }
            case .failure(let error):
                
                completionHandler(.failure(error))
                
            }
        }
    }
}
