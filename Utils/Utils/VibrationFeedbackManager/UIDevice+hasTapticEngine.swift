//
//  UIDevice+hasTapticEngine.swift
//  Utils
//
//  Created by Pavel Marinchenko on 9/10/18.
//  Copyright © 2018 Surf. All rights reserved.
//

import Device_swift

extension UIDevice {
    var hasTapticEngine: Bool {
        let device = UIDevice.current.deviceType
        return device == .iPhone6S || device == .iPhone6SPlus || hasHapticFeedback
    }
}
