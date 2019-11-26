//
//  GeolocationService.swift
//  Utils
//
//  Created by Александр Чаусов on 20/11/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import CoreLocation

/// Service for working with user geoposition
public final class GeolocationService: NSObject, GeolocationServiceInterface {

    // MARK: - Private Properties

    private var locationManager: LocationManagerInterface
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

    public init(manager: LocationManagerInterface = CLLocationManager(),
                accuracy: GeolocationAccuracy = .hundredMeters) {
        self.locationManager = manager
        self.accuracy = accuracy
        super.init()
        self.locationManager.desiredAccuracy = accuracy.coreValue
        self.locationManager.delegate = self
    }

    // MARK: - GeolocationServiceInterface

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
        locationRequests.forEach { $0(.success(location)) }
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
        authRequests.forEach { $0(authStatus) }
        authRequests.removeAll()
    }

}

// MARK: - Private Methods

private extension GeolocationService {

    func notifySubscribersAboutError() {
        locationRequests.forEach { $0(.error) }
        locationRequests.removeAll()
    }

    func isAuthorizedStatus(_ status: CLAuthorizationStatus) -> Bool {
        return status == .authorizedAlways || status == .authorizedWhenInUse
    }

}
