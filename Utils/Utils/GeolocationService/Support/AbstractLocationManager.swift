//
//  AbstractLocationManager.swift
//  Utils
//
//  Created by Александр Чаусов on 20/11/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import CoreLocation

/// Abstarct protocol with 'CLLocationManager' interface for testing GeolocationService.
public protocol AbstractLocationManager {
    /// The delegate object to receive update events.
    var delegate: CLLocationManagerDelegate? { get set }
    /// Returns the app’s authorization status for using location services.
    var status: CLAuthorizationStatus { get }
    /// The accuracy of the location data.
    var desiredAccuracy: CLLocationAccuracy { get set }

    /// Requests the one-time delivery of the user’s current location.
    func requestLocation()
    /// Requests the user’s permission to use location services while the app is in use.
    func requestWhenInUseAuthorization()
}

// MARK: - CLLocationManager

extension CLLocationManager: AbstractLocationManager {

    public var status: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }

}
