//
//  AlbumViewModel.swift
//  Nike Sample App
//
//  Created by Greg Martin on 7/22/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation

class AlbumViewModel {
    private let networkManager = RssItunesNetworkManager()
    
    public var didSetAlbumList: (() -> Void)?
    public var didSetError: (() -> Void)?
    
    /// Model of album feed list - didSet calls callback
    var rssFeedList = RssFeedModel() {
        didSet {
            didSetAlbumList?()
        }
    }
    
    /// Error string from api call - didSet calls callback
    var errorString: String? {
        didSet {
            //Only call did set if error string isnt set to nil
            if errorString != nil {
                didSetError?()
            }
        }
    }
    
    /// Calls network manager to get list of albums
    public func getAlbumList() {
        networkManager.getAlbum { [weak self] result in
            switch result {
                case .success(let rssFeedModel):
                    self?.rssFeedList = rssFeedModel
                    self?.errorString = nil
                case .failure(let errorString):
                    self?.rssFeedList = RssFeedModel()
                    self?.errorString = errorString
            }
        }
    }
}
