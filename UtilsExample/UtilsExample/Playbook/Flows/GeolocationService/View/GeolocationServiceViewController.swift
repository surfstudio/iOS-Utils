//
//  GeolocationServiceViewController.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit
import Utils

final class GeolocationServiceViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var subTitle: UILabel!

    // MARK: - Properties

    var output: GeolocationServiceViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - GeolocationServiceViewInput

extension GeolocationServiceViewController: GeolocationServiceViewInput {

    func setupInitialState() {
        configureLabel()
    }

}

// MARK: - Private Methods

private extension GeolocationServiceViewController {

    func configureLabel() {
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
        subTitle.textAlignment = .center
        subTitle.numberOfLines = 0
        subTitle.text = text
    }

}
