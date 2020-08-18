//
//  UIHelperFunctions.swift
//  Nike Sample App
//
//  Created by Greg Martin on 7/24/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import UIKit

public func createLabel(withFontStyle fontStyle: UIFont.TextStyle, numberOfLines lines: Int = 1) -> UILabel {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: fontStyle)
    label.numberOfLines = lines
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
}

public func createAlbumImage() -> UIImageView {
    let imgView = UIImageView()
    imgView.image = UIImage(named: "albumArtPlaceholder")
    imgView.contentMode = .scaleAspectFit
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
}

public func createStoreButton(buttonTitle: String) -> UIButton {
    let button = UIButton()
    button.frame = CGRect(x: 0, y: 0, width: 0, height: 50.0)
    button.setTitle(buttonTitle, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .secondarySystemBackground
    button.setTitleColor(.systemBlue, for: .normal)
    button.layer.borderColor = UIColor.separator.cgColor
    button.layer.borderWidth = 2
    button.clipsToBounds = true
    button.layer.cornerRadius = (button.frame.height/2)
    
    return button
}
