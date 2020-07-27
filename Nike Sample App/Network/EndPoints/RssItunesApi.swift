//
//  RssItunesApi.swift
//  Nike Sample App
//
//  Created by Greg Martin on 7/22/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

private let numberOfAlbums:Int = 100
private let mediaType: String = "apple-music"
private let feedType: String = "top-albums"
private let origin: String = "us"
private let allowExplicit: Bool = true
private let explicit: String = allowExplicit ? "explicit" : "non-explicit"


/// Enum containing all api request for the RSS Itunes api
public enum RssItunesApi {
    case getAlbums
}

// Extending to inherit EndPointType protocol
extension RssItunesApi: EndPointType {
    // The base url for the RSS Itunes API
    var baseURL: URL {
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/")
        else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    // The path to add onto the base url for a given api request
    var path: String {
        switch self {
        case .getAlbums:
            return "\(origin)/\(mediaType)/\(feedType)/all/\(numberOfAlbums)/\(explicit).json"
        }
    }
    
    // Method to use for a given path
    var httpMethod: HTTPMethod {
        return .get
    }
    
    // Task to use for api, can expand to use url parameters or headers
    var task: HTTPTask {
        return .request
    }
}
