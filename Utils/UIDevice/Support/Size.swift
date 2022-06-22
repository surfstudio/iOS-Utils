//
//  Size.swift
//  Device
//
//  Created by Lucas Ortis on 30/10/2015.
//  Copyright © 2015 Ekhoo. All rights reserved.
//

public enum Size: Int, Comparable {

    case unknownSize = 0
#if os(iOS)
    /// iPhone 2G, 3G, 3GS, 4, 4s, iPod Touch 4th gen.
    case screen3_5Inch
    /// iPhone 5, 5s, 5c, SE, iPod Touch 5-7th gen.
    case screen4Inch
    /// iPhone 6, 6s, 7, 8, SE 2nd gen.
    case screen4_7Inch
    /// iPhone 12 Mini
    case screen5_4Inch
    /// iPhone 6+, 6s+, 7+, 8+
    case screen5_5Inch
    /// iPhone X, Xs, 11 Pro
    case screen5_8Inch
    /// iPhone Xr, 11, 12, 12 Pro, 13, 13 Pro
    case screen6_1Inch
    /// iPhone Xs Max, 11 Pro Max
    case screen6_5Inch
    /// iPhone 12 Pro Max, 13 Pro Max
    case screen6_7Inch
    /// iPad Mini, iPad Mini 2, iPad Mini 3, iPad Mini 4
    case screen7_9Inch
    /// iPad mini 6
    case screen8_3Inch
    /// iPad, iPad 2, iPad 3, iPad 4, iPad 5, iPad 6, iPad Air, iPad Air 2, iPad Pro 9.7″
    case screen9_7Inch
    /// iPad 7, iPad (10.2-inch)
    case screen10_2Inch
    /// iPad Air 3, iPad Pro (10.5-inch)
    case screen10_5Inch
    /// iPad Air 4, iPad Pro 12.9″
    case screen10_9Inch
    /// iPad Pro 11″
    case screen11Inch
    /// iPad Pro 12.9″
    case screen12_9Inch
#elseif os(OSX)
    case screen11Inch
    case screen12Inch
    case screen13Inch
    case screen14Inch
    case screen15Inch
    case screen16Inch
    case screen17Inch
    case screen20Inch
    case screen21_5Inch
    case screen24Inch
    case screen27Inch
#endif

    public static func ==(lhs: Size, rhs: Size) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }

    public static func <(lhs: Size, rhs: Size) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
