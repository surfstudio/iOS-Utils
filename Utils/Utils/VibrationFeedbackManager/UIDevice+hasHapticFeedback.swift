//
//  UIDevice+hasHapticFeedback.swift
//  Utils
//
//  Created by Павел Маринченко on 9/10/18.
//  Copyright © 2018 Surf. All rights reserved.
//

import Device_swift

public extension UIDevice {
    // haptic feedback support guarantees that device supports taptic engine too.
    var hasHapticFeedback: Bool {
        let device = UIDevice.current.deviceType
        return device == .iPhone7 || device == .iPhone7Plus || device == .iPhone8 || device == .iPhone8Plus || device == .iPhoneX
    }
}
