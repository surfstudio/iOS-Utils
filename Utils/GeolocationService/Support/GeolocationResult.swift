//
//  GeolocationResult.swift
//  Utils
//
//  Created by Александр Чаусов on 20/11/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import CoreLocation

/// Available results for request on user location
public enum GeolocationResult: Equatable {
    case success(CLLocation)
    /// denied access to the user location
    case denied
    /// some error occurred
    case error
}
