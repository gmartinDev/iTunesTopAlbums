//
//  AppUtility.swift
//  Nike Sample App
//
//  Created by Greg Martin on 7/25/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import Foundation
import UIKit

struct AppUtility {

    /// Update the orientation lock 
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {

        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    /// Adjust lock orientation and rotate to selected orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {

        self.lockOrientation(orientation)

        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }

}
