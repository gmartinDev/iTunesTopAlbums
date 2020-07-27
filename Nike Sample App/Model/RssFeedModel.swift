//
//  RssFeedModel.swift
//  Nike Sample App
//
//  Created by Greg Martin on 7/22/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

struct AuthorModel: Decodable {
    var name: String
    var uri: String
    
    init() {
        name = ""
        uri = ""
    }
}

struct RssFeedModel: Decodable {
    var title: String?
    var id: String?
    var author: AuthorModel?
    var country: String?
    var updated: String?
    var results: [AlbumModel]?
    
    enum RssFeedKeys: CodingKey {
        case feed
        case title
        case id
        case author
        case country
        case updated
        case results
    }
    
    init() {
        title = nil
        id = nil
        author = nil
        country = nil
        updated = nil
        results = nil
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: RssFeedKeys.self)
            //all the data is held within the feed container
            let feed = try container.nestedContainer(keyedBy: RssFeedKeys.self, forKey: .feed)
            
            title = try feed.decode(String.self, forKey: .title)
            id = try feed.decode(String.self, forKey: .id)
            author = try feed.decode(AuthorModel.self, forKey: .author)
            country = try feed.decode(String.self, forKey: .country)
            updated = try feed.decode(String.self, forKey: .updated)
            results = try feed.decode([AlbumModel].self, forKey: .results)
        } catch (let error as NSError) {
            print("An error occured decoding RssFeed: \(error.localizedDescription)")
        }
    }
}
