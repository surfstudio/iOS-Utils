//
//  MapRoutingServiceInterface.swift
//  Utils
//
//  Created by Александр Чаусов on 30.10.2021.
//  Copyright © 2021 Surf. All rights reserved.
//

import CoreLocation

/// Протокол для сервиса построения маршрута в различных приложениях
public protocol MapRoutingServiceInterface {
    /// Возвращает список установленных приложений, через которые можно построить маршрут
    var availableApplications: [MapApplication] { get }
    /// Используется для построения маршрута в определенном приложении
    ///
    /// Если есть доступ к геопозиции и выбрана точная геопозиция,
    /// в приложение передаются координаты начала и конца маршрута.
    /// Если доступа нет или геопозиция не точная,
    /// то передается только координаты конца маршрута.
    func buildRoute(to destination: CLLocationCoordinate2D,
                    in application: MapApplication,
                    onComplete: (() -> Void)?)
}
