//
//  MapRoutingService.swift
//  Utils
//
//  Created by Александр Чаусов on 30.10.2021.
//  Copyright © 2021 Surf. All rights reserved.
//

import CoreLocation

/// Сервис для построения маршрута в различных приложениях
public final class MapRoutingService: MapRoutingServiceInterface {

    // MARK: - Private Propeties

    private let locationService: MapRoutingLocationServiceInterface

    // MARK: - Initialization

    public init(locationService: MapRoutingLocationServiceInterface) {
        self.locationService = locationService
    }

    // MARK: - MapRoutingServiceInterface

    public var availableApplications: [MapApplication] {
        let applications = MapApplication.allCases
        var available: [MapApplication] = []
        for application in applications {
            guard
                let url = application.schemaUrl,
                UIApplication.shared.canOpenURL(url)
            else {
                continue
            }
            available.append(application)
        }

        // убираем ссылку на гугл карты в браузере, если есть приложение гугл карт
        if available.contains(.googleApp), let googleUrlIndex = available.firstIndex(of: .googleUrl) {
            available.remove(at: googleUrlIndex)
        }
        return available
    }

    public func buildRoute(to destination: CLLocationCoordinate2D,
                           in application: MapApplication,
                           onComplete: (() -> Void)?) {
        switch (locationService.isLocationAccessAllowed, locationService.isAllowedFullAccuracyLocation) {
        case (true, true):
            tryBuildRouteForCurrentLocation(to: destination,
                                            in: application,
                                            onComplete: onComplete)
        default:
            let url = application.routeUrl(startCoordinate: nil,
                                           endCoordinate: destination)
            onComplete?()
            open(url: url)
        }
    }

}

// MARK: - Private Methods

private extension MapRoutingService {

    func tryBuildRouteForCurrentLocation(to destination: CLLocationCoordinate2D,
                                         in application: MapApplication,
                                         onComplete: (() -> Void)?) {
        locationService.getCurrentLocation { [weak self] userLocation in
            let url = application.routeUrl(startCoordinate: userLocation,
                                           endCoordinate: destination)
            onComplete?()
            self?.open(url: url)
        }
    }

    func open(url: URL?) {
        guard
            let url = url,
            UIApplication.shared.canOpenURL(url)
        else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}
