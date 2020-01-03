//
//  UIDevice.swift
//  Utils
//
//  Created by Vladislav Krupenko on 03/01/2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Device

public extension UIDevice {

    /// Returns 'true' if iOS 13 is available
    static var isAvailableIos13: Bool {
        if #available(iOS 13.0, *) {
            return true
        } else {
            return false
        }
    }

    /// Returns 'true' if device have 4inch diagonal screen or smaller (5, 5s, 5c, SE)
    static var isSmallPhone: Bool {
        let smallSizes: [Size] = [.screen3_5Inch,
                                  .screen4Inch]
        return smallSizes.contains(Device.size())
    }

    /// Returns `true` if device have screen size of X version
    static var isXPhone: Bool {
        let xSizes: [Size] = [.screen5_8Inch, .screen6_1Inch, .screen6_5Inch]
        return xSizes.contains(Device.size())
    }

    /// Returns 'true' if device have 4.7inch and 5.5inch diagonal screen (6/7/8 normal  or '+')
    static var isNormalPhone: Bool {
        let normalSizes: [Size] = [.screen4_7Inch,
                                   .screen5_5Inch]
        return normalSizes.contains(Device.size())
    }

    /// Returns 'true' if device is phone and have dioganal screen 5.8inch or bigger (X, XS, XR, XS Max).
    static var isLargePhone: Bool {
        let largeSizes: [Size] = [.screen5_8Inch,
                                  .screen6_1Inch,
                                  .screen6_5Inch]
        return largeSizes.contains(Device.size())
    }

    /// Returns 'true' if current device is iPad
    static var isPad: Bool {
        let padSizes: [Size] = [.screen7_9Inch,
                                .screen9_7Inch,
                                .screen10_5Inch,
                                .screen12_9Inch]
        return padSizes.contains(Device.size())
    }

}
