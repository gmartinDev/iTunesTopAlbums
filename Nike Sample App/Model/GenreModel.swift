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
            genreId = try container.decodeIfPresent(String.self, forKey: .genreId)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            url = try container.decodeIfPresent(URL.self, forKey: .url)
        } catch (let error as NSError) {
            print(error.localizedDescription)
        }
    }
}
