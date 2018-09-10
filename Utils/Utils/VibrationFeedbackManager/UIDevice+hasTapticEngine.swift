//
//  UIDevice+hasTapticEngine.swift
//  Utils
//
//  Created by Павел Маринченко on 9/10/18.
//  Copyright © 2018 Surf. All rights reserved.
//

import Device_swift

public extension UIDevice {
    var hasTapticEngine: Bool {
        let device = UIDevice.current.deviceType
        return device == .iPhone6S || device == .iPhone6SPlus || hasHapticFeedback
    }
}
