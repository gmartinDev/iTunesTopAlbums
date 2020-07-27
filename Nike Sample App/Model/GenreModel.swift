//
//  GenreModel.swift
//  Nike Sample App
//
//  Created by Greg Martin on 7/22/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct GenreModel: Decodable {
    var genreId: String?
    var name: String?
    var url: URL?
    
    enum GenreKeys: CodingKey {
        case genreId
        case name
        case url
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: GenreKeys.self)
            
            if container.contains(.genreId) {
                genreId = try container.decode(String.self, forKey: .genreId)
            } else {
                genreId = nil
            }
            if container.contains(.name) {
                name = try container.decode(String.self, forKey: .name)
            } else {
                name = nil
            }
            
            if container.contains(.url) {
                url = try container.decode(URL.self, forKey: .url)
            } else {
                url = nil
            }
        } catch (let error as NSError) {
            print(error.localizedDescription)
        }
    }
}
