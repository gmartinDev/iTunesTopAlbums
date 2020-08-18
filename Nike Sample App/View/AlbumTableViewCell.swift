//
//  AlbumTableViewCell.swift
//  Nike Sample App
//
//  Created by Greg Martin on 7/22/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    var albumInfo: AlbumModel? {
        didSet {
            //make sure albumInfo isnt nil
            guard let album = self.albumInfo else { return }
            
            if let albumArtUrl = album.artworkUrl {
                albumArt.loadRemoteImage(fromUrl: albumArtUrl)
            }
            
            self.albumLabel.text = album.name
            self.artistLabel.text = album.artistName
        }
    }
    
    /// UIImageView of the album artwork
    let albumArt: UIImageView
    /// UILabel to display the name of the album
    let albumLabel: UILabel
    /// UILabel to display the name of the artist
    let artistLabel: UILabel

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        albumArt = createAlbumImage()
        albumLabel = createLabel(withFontStyle: .title1)
        artistLabel = createLabel(withFontStyle: .title2)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Create views to show in cell
        self.contentView.addSubview(albumArt)
        self.contentView.addSubview(albumLabel)
        self.contentView.addSubview(artistLabel)
        
        layoutCellConstraints()
    }
    
    required init?(coder: NSCoder) {
        albumArt = createAlbumImage()
        albumLabel = createLabel(withFontStyle: .subheadline)
        artistLabel = createLabel(withFontStyle: .footnote)
        super.init(coder: coder)
    }
    
    //Layout the views within the cell
    private func layoutCellConstraints() {
        NSLayoutConstraint.activate([
            //Image
            albumArt.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            albumArt.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            albumArt.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10),
            albumArt.widthAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10),
            
            //Album - Top of cell
            albumLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            albumLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -5),
            albumLabel.leadingAnchor.constraint(equalTo: albumArt.trailingAnchor, constant: 20),
            albumLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            //Artist - Bottom of cell
            artistLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.centerYAnchor, multiplier: 5),
            artistLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            artistLabel.leadingAnchor.constraint(equalTo: albumLabel.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
