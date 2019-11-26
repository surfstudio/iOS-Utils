//
//  GeolocationServiceInterface.swift
//  Utils
//
//  Created by Александр Чаусов on 20/11/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

// MARK: - Typealiases

public typealias GeolocationCompletion = (GeolocationResult) -> Void
public typealias GeolocationAuthCompletion = (GeolocationAuthResult) -> Void

/// Service for working with user geoposition
public protocol GeolocationServiceInterface {
    /// Methods returns user location at completion block
    /// or 'denied' if we haven't permission on user geoposition
    /// (or 'error' if some error occured)
    func getCurrentLocation(_ completion: @escaping GeolocationCompletion)
    /// Method allows you to know current geolocation permission state.
    /// If we haven't already request it - returns 'requesting' case
    func requestAuthorization(_ completion: @escaping GeolocationAuthCompletion)
}
