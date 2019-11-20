//
//  GeolocationService.swift
//  Utils
//
//  Created by Александр Чаусов on 20/11/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import CoreLocation

/// Service for working with user geoposition
public final class GeolocationService: NSObject, GeolocationAbstractService {

    // MARK: - Private Properties

    private var locationManager: AbstractLocationManager
    private var locationRequests: [GeolocationCompletion] = []
    private var authRequests: [GeolocationAuthCompletion] = []

    // MARK: - Public Properties

    /// The accuracy of the location data
    public var accuracy: GeolocationAccuracy {
        didSet {
            locationManager.desiredAccuracy = accuracy.coreValue
        }
    }

    // MARK: - Initialization

    public init(manager: AbstractLocationManager = CLLocationManager(),
                accuracy: GeolocationAccuracy = .hundredMeters) {
        self.locationManager = manager
        self.accuracy = accuracy
        super.init()
        self.locationManager.desiredAccuracy = accuracy.coreValue
        self.locationManager.delegate = self
    }

    // MARK: - GeolocationAbstractService

    public func getCurrentLocation(_ completion: @escaping GeolocationCompletion) {
        let status = locationManager.status
        if isAuthorizedStatus(status) {
            locationRequests.append(completion)
            locationManager.requestLocation()
        } else {
            completion(.denied)
        }
    }

    public func requestAuthorization(_ completion: @escaping GeolocationAuthCompletion) {
        let status = locationManager.status
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            completion(.success)
        case .denied, .restricted:
            completion(.denied)
        default:
            completion(.requesting)
            authRequests.append(completion)
            locationManager.requestWhenInUseAuthorization()
        }
    }

}

// MARK: - CLLocationManagerDelegate

extension GeolocationService: CLLocationManagerDelegate {

    public func locationManager(_ manager: CLLocationManager,
                                didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            notifySubscribersAboutError()
            return
        }
        for request in locationRequests {
            request(.success(location))
        }
        locationRequests.removeAll()
    }

    public func locationManager(_ manager: CLLocationManager,
                                didFailWithError error: Error) {
        notifySubscribersAboutError()
    }

    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
        guard status != .notDetermined else {
            return
        }
        let authStatus: GeolocationAuthResult = isAuthorizedStatus(status) ? .success : .failure
        for request in authRequests {
            request(authStatus)
        }
        authRequests.removeAll()
    }

}

// MARK: - Private Methods

private extension GeolocationService {

    func notifySubscribersAboutError() {
        for request in locationRequests {
            request(.error)
        }
        locationRequests.removeAll()
    }

    func isAuthorizedStatus(_ status: CLAuthorizationStatus) -> Bool {
        return status == .authorizedAlways || status == .authorizedWhenInUse
    }

}
