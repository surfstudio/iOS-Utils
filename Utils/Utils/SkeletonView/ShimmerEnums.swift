//
//  ShimmerEnums.swift
//  Utils
//
//  Created by Artemii Shabanov on 21/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

/// Different types of shimmer gradient width
/// Custom case provides opportunity to hard set ratio
enum GradientWidth {
    case narrow
    case `default`
    case wide
    case custom(Double)

    var gradientLocations: (left: [NSNumber], right: [NSNumber]) {
        var leftLocations:  [NSNumber] = []
        var rightLocations: [NSNumber] = []
        var ratio = 0.0
        switch self {
        case .narrow:
            ratio = 0.25
        case .default:
            ratio = 0.5
        case .wide:
            ratio = 1.0
        case .custom(let customRatio):
            ratio = min(max(customRatio, 0.0), 1.0)
        }
        leftLocations  = [0 - ratio, 0 - ratio / 2,         0] as [NSNumber]
        rightLocations = [        1, 1 + ratio / 2, 1 + ratio] as [NSNumber]
        return (left: leftLocations, right: rightLocations)
    }
}

/// Left or right
enum ShimmeringDirection {
    case left
    case right
}
