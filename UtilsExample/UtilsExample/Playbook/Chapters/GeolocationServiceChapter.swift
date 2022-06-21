//
//  OTPFieldChapter.swift
//  UtilsExample
//
//  Created by Евгений Васильев on 21.06.2022.
//

import SurfPlaybook
import UIKit
import Utils

final class GeolocationServiceChapter {

    func build() -> PlaybookChapter {
        let chapter = PlaybookChapter(name: "GeolocationService", pages: [])
        chapter
            .add(page: label)
        return chapter
    }

}

// MARK: - Pages

private extension GeolocationServiceChapter {

    var label: PlaybookPage {
        return PlaybookPage(name: "GeolocationService", description: nil) { () -> UIView in
            var text = ""
            // Создание сервиса:
            let service = GeolocationService()

            // Получение статуса доступа к сервисам геолокации:
            service.requestAuthorization { result in
                switch result {
                case .success:
                    // access is allowed
                    text = "Success"
                case .denied:
                    // user denied access to geolocation
                    text = "Denied"
                case .failure:
                    // user doesn't gave permission on his geolocation in the system dialog
                    text = "Failure"
                case .requesting:
                    // system dialog is currently displayed
                    text = "Requesting"
                }
            }

            // Получение геопозиции пользователя:

            service.getCurrentLocation { result in
                switch result {
                case .success(let location):
                    // do something usefull with user location
                    text += "\(location)"
                case .denied:
                    // user denied access to geolocation
                    break
                case .error:
                    // some error ocured
                    break
                }
            }
            let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 0
            label.text = text
            let container = ViewContainer(label, width: 400, height: 400)
            return container
        }
    }

}

