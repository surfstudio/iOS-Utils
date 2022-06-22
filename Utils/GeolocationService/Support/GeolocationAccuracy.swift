//
//  GeolocationAccuracy.swift
//  Utils
//
//  Created by Александр Чаусов on 20/11/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import CoreLocation

/// Available accuracy of the location data
public enum GeolocationAccuracy {
    case bestForNavigation
    case best
    case tenMeters
    case hundredMeters
    case kilometer
    case threeKilometers

    // MARK: - Properties

    var coreValue: CLLocationAccuracy {
        switch self {
        case .bestForNavigation:
            return kCLLocationAccuracyBestForNavigation
        case .best:
            return kCLLocationAccuracyBest
        case .tenMeters:
            return kCLLocationAccuracyNearestTenMeters
        case .hundredMeters:
            return kCLLocationAccuracyHundredMeters
        case .kilometer:
            return kCLLocationAccuracyKilometer
        case .threeKilometers:
            return kCLLocationAccuracyThreeKilometers
        }
    }

}
