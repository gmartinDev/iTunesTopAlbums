//
//  UIImageView_Extension.swift
//  Nike Sample App
//
//  Created by Greg Martin on 7/24/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadRemoteImage(fromUrl url: URL) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
