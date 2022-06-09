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
    public static func calculateApproximateDistance(between firstPoint: CLLocationCoordinate2D,
                                                    and secondPoint: CLLocationCoordinate2D) -> Double {
        let sourceLocation = CLLocation(latitude: firstPoint.latitude, longitude: firstPoint.longitude)
        let destinationLocation = CLLocation(latitude: secondPoint.latitude, longitude: secondPoint.longitude)
        return destinationLocation.distance(from: sourceLocation)
    }

    /// Method returns nearest route distance between two points, using MKDirections
    public static func calculateDistance(between firstPoint: CLLocationCoordinate2D,
                                         and secondPoint: CLLocationCoordinate2D,
                                         completion: @escaping ((Double?) -> Void)) {
        let directionRequest = MKDirections.Request()
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

    /// Formats distance value using your pattern for meters and kilometers.
    ///
    /// Example of usage:
    /// ```
    /// print(formatDistance(12310, meterPattern: "m", kilometrPattern: "km"))
    /// // Prints "12.3 km"
    /// ```
    ///
    /// - Parameters:
    ///   - distance: Distance in meters that should be formatted
    ///   - meterPattern: Pattern for meters formatting
    ///   - kilometrPatter: Pattern for kilometers formatting
    ///   - kmBoundaryLevel: Pass in kmBoundaryLevel value, after which the
    /// value of kilometers will be rounded to an integer value. Default value is 50000
    /// - Returns: Formatted distance string
    public static func formatDistance(_ distance: Double, meterPattern: String,
                                      kilometrPatter: String, kmBoundaryLevel: Double = 50000) -> String {
        switch distance {
        case ..<0:
            return ["0", meterPattern].joined(separator: " ")
        case ..<1000:
            return [String(format: "%.0f", distance), meterPattern].joined(separator: " ")
        case ..<kmBoundaryLevel:
            return [String(format: "%.1f", distance / 1000), kilometrPatter].joined(separator: " ")
        default:
            return [String(format: "%.0f", distance / 1000), kilometrPatter].joined(separator: " ")
        }
    }

}
