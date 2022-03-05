//
//  MapApplication.swift
//  Utils
//
//  Created by Александр Чаусов on 30.10.2021.
//  Copyright © 2021 Surf. All rights reserved.
//

import CoreLocation

/// Возможные приложения, способные работать с картами
public enum MapApplication: CaseIterable {
    case apple
    case googleApp
    case yandex
    case twoGIS
    case googleUrl

    var schemaUrl: URL? {
        let schemaString: String
        switch self {
        case .apple:
            schemaString = "https://maps.apple.com/maps"
        case .googleApp:
            schemaString = "comgooglemaps://"
        case .yandex:
            schemaString = "yandexmaps://"
        case .twoGIS:
            schemaString = "dgis://"
        case .googleUrl:
            schemaString = "https://www.google.com/maps"
        }

        return URL(string: schemaString)
    }

    // MARK: - Public Methods

    /// Выполняет построение URL, открыв который - можно перейти к маршруту в выбранном приложении
    public func routeUrl(startCoordinate: CLLocationCoordinate2D?,
                         endCoordinate: CLLocationCoordinate2D) -> URL? {
        switch self {
        case .apple:
            return Self.appleMapsRoute(startCoordinate: startCoordinate, endCoordinate: endCoordinate)
        case .googleApp:
            return Self.googleAppRoute(startCoordinate: startCoordinate, endCoordinate: endCoordinate)
        case .yandex:
            return Self.yandexRoute(startCoordinate: startCoordinate, endCoordinate: endCoordinate)
        case .twoGIS:
            return Self.twoGISRoute(startCoordinate: startCoordinate, endCoordinate: endCoordinate)
        case .googleUrl:
            return Self.googleUrlRoute(startCoordinate: startCoordinate, endCoordinate: endCoordinate)
        }
    }

}

// MARK: - Private Methods

private extension MapApplication {

    static func generateLocationParameters(startCoordinate: CLLocationCoordinate2D?,
                                           endCoordinate: CLLocationCoordinate2D) -> (saddr: String, daddr: String) {
        var saddr = ""
        if let startCoordinate = startCoordinate {
            saddr = String(format: "%f,%f", startCoordinate.latitude, startCoordinate.longitude)
        }
        let daddr = String(format: "%f,%f", endCoordinate.latitude, endCoordinate.longitude)

        return (saddr: saddr, daddr: daddr)
    }

    /// Построение URL-схемы для открытия приложения apple-карт
    ///
    /// https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html
    static func appleMapsRoute(startCoordinate: CLLocationCoordinate2D?,
                               endCoordinate: CLLocationCoordinate2D) -> URL? {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "maps.apple.com"
        urlComponents.path = "/maps"

        let (saddr, daddr) = generateLocationParameters(startCoordinate: startCoordinate,
                                                        endCoordinate: endCoordinate)
        urlComponents.queryItems = [
            URLQueryItem(name: "saddr", value: saddr),
            URLQueryItem(name: "daddr", value: daddr)
        ]

        return urlComponents.url
    }

    /// Построение URL-схемы для открытия приложения google-карт
    ///
    /// https://developers.google.com/maps/documentation/urls/ios-urlscheme
    static func googleAppRoute(startCoordinate: CLLocationCoordinate2D?,
                               endCoordinate: CLLocationCoordinate2D) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "comgooglemaps"
        urlComponents.host = ""

        let (saddr, daddr) = generateLocationParameters(startCoordinate: startCoordinate,
                                                        endCoordinate: endCoordinate)
        urlComponents.queryItems = [
            URLQueryItem(name: "saddr", value: saddr),
            URLQueryItem(name: "daddr", value: daddr)
        ]

        return urlComponents.url
    }

    /// Построение URL-схемы для открытия приложения google-карт
    ///
    /// https://yandex.ru/dev/yandex-apps-launch/maps/doc/concepts/yandexmaps-ios-app.html
    static func yandexRoute(startCoordinate: CLLocationCoordinate2D?,
                            endCoordinate: CLLocationCoordinate2D) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "yandexmaps"
        urlComponents.host = "maps.yandex.ru"
        urlComponents.path = "/"

        let (saddr, daddr) = generateLocationParameters(startCoordinate: startCoordinate,
                                                        endCoordinate: endCoordinate)
        let rtext = [saddr, daddr].joined(separator: "~")
        urlComponents.queryItems = [
            URLQueryItem(name: "rtext", value: rtext)
        ]

        return urlComponents.url
    }

    /// Построение URL-схемы для открытия google-карт в Safari
    ///
    /// https://help.2gis.ru/question/razrabotchikam-zapusk-mobilnogo-prilozheniya-2gis
    static func twoGISRoute(startCoordinate: CLLocationCoordinate2D?,
                            endCoordinate: CLLocationCoordinate2D) -> URL? {
        var scheme = "dgis://2gis.ru/routeSearch/rsType/car"
        if let startCoordinate = startCoordinate {
            let fromLocation = String(format: "/from/%f,%f",
                                      startCoordinate.longitude,
                                      startCoordinate.latitude)
            scheme.append(fromLocation)
        }
        let toLocation = String(format: "/to/%f,%f",
                                endCoordinate.longitude,
                                endCoordinate.latitude)
        scheme.append(toLocation)
        return URL(string: scheme)
    }

    /// Построение URL-схемы для открытия google-карт в Safari
    ///
    /// https://developers.google.com/maps/documentation/urls/ios-urlscheme
    static func googleUrlRoute(startCoordinate: CLLocationCoordinate2D?,
                               endCoordinate: CLLocationCoordinate2D) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.google.com"
        urlComponents.path = "/maps"

        let (saddr, daddr) = generateLocationParameters(startCoordinate: startCoordinate,
                                                        endCoordinate: endCoordinate)
        urlComponents.queryItems = [
            URLQueryItem(name: "saddr", value: saddr),
            URLQueryItem(name: "daddr", value: daddr)
        ]

        return urlComponents.url
    }

}
