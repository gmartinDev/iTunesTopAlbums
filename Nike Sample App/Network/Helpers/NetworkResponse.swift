//
//  NetworkResponse.swift
//  Nike Sample App
//
//  Created by Greg Martin on 7/22/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

/// Used to convert HTTP Codes to generic error strings
/// - Parameter response: The response from the API call
/// - Returns: Result type that will contain an error string if failed
public func handleNetworkResponse(_ response: HTTPURLResponse) -> HTTPResult<String> {
    switch response.statusCode {
    case 200...299:
        return .success
    case 401...500:
        return .failure(NetworkResponse.authenticationError.rawValue)
    case 501...599:
        return .failure(NetworkResponse.badRequest.rawValue)
    case 600:
        return .failure(NetworkResponse.outdated.rawValue)
    default:
        return .failure(NetworkResponse.failed.rawValue)
    }
}
