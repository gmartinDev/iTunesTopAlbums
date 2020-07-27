//
//  RSSNetworkManager.swift
//  Nike Sample App
//
//  Created by Greg Martin on 7/22/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct RssItunesNetworkManager {
    private let router = Router<RssItunesApi>()
    
    
    /// Calls itunes rss api to get list of albums
    /// - Parameter completion: Returns a result type on success containing a model of the api response or on failure an error string
    func getAlbum(completion: @escaping (NetworkResult<RssFeedModel, String>) -> Void) {
        self.router.request(.getAlbums) {
            (data, response, error) in
            if error != nil {
                completion(.failure("Please check your network connection."))
            }
            if let response = response as? HTTPURLResponse {
                let result = handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(NetworkResponse.noData.rawValue))
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(RssFeedModel.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NetworkResponse.unableToDecode.rawValue))
                    }
                case .failure(let networkFailureError):
                    completion(.failure(networkFailureError))
                }
            }
        }
    }
}
