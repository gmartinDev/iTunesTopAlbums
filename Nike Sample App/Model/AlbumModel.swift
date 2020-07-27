//
//  AlbumModel.swift
//  Nike Sample App
//
//  Created by Greg Martin on 7/22/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct AlbumModel: Decodable {
    var artistName: String?
    var id: String?
    var releaseDateString: String?
    var name: String?
    var kind: String?
    var copyright: String?
    var artworkUrl: URL?
    var genres: [GenreModel]?
    var url: URL?
    
    enum AlbumKeys: String, CodingKey {
        case artistName
        case id
        case releaseDateString = "releaseDate"
        case name
        case kind
        case copyright
        case artworkUrl = "artworkUrl100"
        case genres
        case url
    }
    
    init() {
        artistName = nil
        id = nil
        releaseDateString = nil
        name = nil
        kind = nil
        copyright = nil
        artworkUrl = nil
        genres = nil
        url = nil
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: AlbumKeys.self)
            
            artistName = try container.decode(String.self, forKey: .artistName)
            id = try container.decode(String.self, forKey: .id)
            releaseDateString = try container.decode(String.self, forKey: .releaseDateString)
            name = try container.decode(String.self, forKey: .name)
            kind = try container.decode(String.self, forKey: .kind)
            copyright = try container.decode(String.self, forKey: .copyright)
            artworkUrl = try container.decode(URL.self, forKey: .artworkUrl)
            genres = try container.decode([GenreModel].self, forKey: .genres)
            url = try container.decode(URL.self, forKey: .url)
        } catch (let error as NSError) {
            print(error.localizedDescription)
        }
    }
}
