//
//  MapRoutingLocationServiceInterface.swift
//  Utils
//
//  Created by Александр Чаусов on 30.10.2021.
//  Copyright © 2021 Surf. All rights reserved.
//

import CoreLocation

/// Вспомогательный протокол для сервиса геолокации,
/// необходимого для использования MapRoutingService
public protocol MapRoutingLocationServiceInterface: AnyObject {
    /// Равно true, когда пользователь разрешил доступ к геопозиции
    var isLocationAccessAllowed: Bool { get }
    /// Равно true, когда пользователь разрешил использование точной геопозиции
    var isAllowedFullAccuracyLocation: Bool { get }
    /// Вовращает текущую геопозицию пользователя, если она известна,
    /// и nil во всех остальных случаях
    func getCurrentLocation(_ completion: @escaping ((CLLocationCoordinate2D?) -> Void))
}
