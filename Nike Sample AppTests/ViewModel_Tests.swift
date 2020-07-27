//
//  ViewModel_Tests.swift
//  Nike Sample AppTests
//
//  Created by Greg Martin on 7/26/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import XCTest
@testable import Nike_Sample_App

class ViewModel_Tests: XCTestCase {

    var jsonPath: String?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let path = Bundle(for: type(of: self)).path(forResource: "10AlbumRssFeed", ofType: "json") else {
            fatalError("Can't find test json file")
        }
        self.jsonPath = path
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAlbumRssFeedResponse() throws {
        guard let path = jsonPath else {
            XCTFail("Can't find test json file")
            return
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let feedModel = try JSONDecoder().decode(RssFeedModel.self, from:data)
        
        XCTAssertNotNil(feedModel, "RssFeedModel should not be nil")
        
        XCTAssertEqual(feedModel.title, "Coming Soon", "Feed Model title is incorrect")
        XCTAssertEqual(feedModel.id, "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json", "Incorrect id from RssModel")
        XCTAssertEqual(feedModel.country, "us", "Incorect country")
        XCTAssertEqual(feedModel.updated, "2020-07-25T02:11:53.000-07:00", "Updated string is unequal")
        XCTAssertNotNil(feedModel.results, "Results should not be nil")
        XCTAssertEqual(feedModel.results?.count, 10, "Incorrect number of results")
        
        let authorModel: AuthorModel? = feedModel.author
        XCTAssertNotNil(authorModel, "Author is nil when it should not be")
        XCTAssertEqual(authorModel?.name, "iTunes Store", "RssModel author is incorrect")
        XCTAssertEqual(authorModel?.uri, "http://wwww.apple.com/us/itunes/", "RssModel Author uri is incorrect")
        
    }
    
    func testAlbumModel() throws {
        guard let path = self.jsonPath else {
            XCTFail("Can't find test json file")
            return
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let feedModel = try JSONDecoder().decode(RssFeedModel.self, from: data)
        
        var expectedAlbum = AlbumModel()
        expectedAlbum.artistName = "Brandy"
        expectedAlbum.id = "1523385900"
        expectedAlbum.releaseDateString = "2020-07-31"
        expectedAlbum.name = "B7"
        expectedAlbum.kind = "album"
        expectedAlbum.copyright = "℗ 2020 Brand Nu, Inc./ Entertainment One U.S., LP"
        expectedAlbum.artworkUrl = URL(string: "https://is4-ssl.mzstatic.com/image/thumb/Music114/v4/20/fb/bd/20fbbda4-38ef-be62-a4b1-9969c9370842/634164638528.png/200x200bb.png")
        expectedAlbum.url = URL(string:" https://music.apple.com/us/album/b7/1523385900?app=music")
        
        XCTAssertNotNil(feedModel, "RssFeedModel should not be nil")
        let firstResult = feedModel.results?.first
        XCTAssertNotNil(firstResult, "First album result should not be nil")
        XCTAssertEqual(firstResult?.artistName, expectedAlbum.artistName, "Album artist does not match")
        XCTAssertEqual(firstResult?.id, expectedAlbum.id, "Album id does not match")
        XCTAssertEqual(firstResult?.releaseDateString, expectedAlbum.releaseDateString, "Album release date does not match")
        XCTAssertEqual(firstResult?.name, expectedAlbum.name, "Album name does not match")
        XCTAssertEqual(firstResult?.kind, expectedAlbum.kind, "Kind should be 'album'")
        XCTAssertEqual(firstResult?.copyright, expectedAlbum.copyright, "Album copyright does not match")
        XCTAssertEqual(firstResult?.artworkUrl, expectedAlbum.artworkUrl, "Album artwork url does not match")
        XCTAssertEqual(firstResult?.genres?.count, 2, "Number of genres do not match")
    }
    
    func testGenreModel() throws {
        guard let path = self.jsonPath else {
            XCTFail("Can't find test json file")
            return
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let feedModel = try JSONDecoder().decode(RssFeedModel.self, from: data)
        
        XCTAssertNotNil(feedModel, "RssFeedModel should not be nil")
        let firstResult = feedModel.results?.first
        let genres: [GenreModel]? = firstResult?.genres
        
        XCTAssertNotNil(genres, "Genres should not be nil")
        XCTAssertEqual(genres?.count, 2, "There should be 2 genres for the first album")
        
        let firstGenre = genres?.first
        XCTAssertNotNil(firstGenre, "First Genre should not be nil")
        XCTAssertEqual(firstGenre?.genreId, "15", "Genre id does not match")
        XCTAssertEqual(firstGenre?.name, "R&B/Soul", "Genre name does not match")
        XCTAssertEqual(firstGenre?.url?.absoluteString, "https://itunes.apple.com/us/genre/id15", "Genre URL does not match")
        
        let secondGenre = genres?[1]
        XCTAssertNotNil(secondGenre, "Second Genre should not be nil")
        XCTAssertEqual(secondGenre?.genreId, "34", "Genre id does not match")
        XCTAssertEqual(secondGenre?.name, "Music", "Genre name does not match")
        XCTAssertEqual(secondGenre?.url?.absoluteString, "https://itunes.apple.com/us/genre/id34", "Genre URL does not match")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
