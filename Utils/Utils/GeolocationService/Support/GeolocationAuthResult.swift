//
//  GeolocationAuthResult.swift
//  Utils
//
//  Created by Александр Чаусов on 20/11/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

/// Available results for request on user permission status
public enum GeolocationAuthResult {
    /// user have permission on geolocation
    case success
    /// user haven't permission on geolocation
    case denied
    /// user doesn't give permission on his geolocation
    case failure
    /// system dialog reqeusts user permission at this moment
    case requesting
}
