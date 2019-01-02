//
//  RouteMeasurer.swift
//  Utils
//
//  Created by Александр Чаусов on 02/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import MapKit

/// Utils for measure distance between two points and format this distance
public final class RouteMeasurer {

    /// Method returns direct distance between two points
    public static func calculateApproximateDistance(between firstPoint: CLLocationCoordinate2D, and secondPoint: CLLocationCoordinate2D) -> Double {
        let sourceLocation = CLLocation(latitude: firstPoint.latitude, longitude: firstPoint.longitude)
        let destinationLocation = CLLocation(latitude: secondPoint.latitude, longitude: secondPoint.longitude)
        return destinationLocation.distance(from: sourceLocation)
    }

    /// Method returns nearest route distance between two points, using MKDirections
    public static func calculateDistance(between firstPoint: CLLocationCoordinate2D, and secondPoint: CLLocationCoordinate2D, completion: @escaping ((Double?) -> Void)) {
        let directionRequest = MKDirectionsRequest()
        let sourcePlacemark = MKPlacemark(coordinate: firstPoint, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: secondPoint, addressDictionary: nil)
        let source = MKMapItem(placemark: sourcePlacemark)
        let destination = MKMapItem(placemark: destinationPlacemark)

        directionRequest.source = source
        directionRequest.destination = destination
        directionRequest.transportType = .any
        let directions = MKDirections(request: directionRequest)

        directions.calculate { (response, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            guard let route = response?.routes.first else {
                completion(nil)
                return
            }
            completion(route.distance)
        }
    }

    /// Method allows you formate distance value, using your pattern for meters and kilometers.
    /// You can pass in the method kmBoundaryLevel value, after which the value of kilometers will be rounded to an integer value.
    public static func formatDistance(_ distance: Double, meterPattern: String, kilometrPatter: String, kmBoundaryLevel: Double = 50000) -> String {
        switch distance {
        case ..<0:
            return join(distance: "0", pattern: meterPattern)
        case ..<1000:
            return join(distance: String(format: "%.0f", distance), pattern: meterPattern)
        case ..<kmBoundaryLevel:
            return join(distance: String(format: "%.1f", distance / 1000), pattern: kilometrPatter)
        default:
            return join(distance: String(format: "%.0f", distance / 1000), pattern: kilometrPatter)
        }
    }

}

// MARK: - Private Methods

private extension RouteMeasurer {

    static func join(distance: String, pattern: String) -> String {
        return distance + " " + pattern
    }

}

