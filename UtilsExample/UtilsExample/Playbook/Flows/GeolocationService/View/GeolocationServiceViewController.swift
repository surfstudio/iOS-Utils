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

    // MARK: - Private Properties

    private let service = GeolocationService()

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
        requestAuthorization()
    }

}

// MARK: - Private Methods

private extension GeolocationServiceViewController {

    func configureLabel() {
        subTitle.textAlignment = .center
        subTitle.numberOfLines = 0
        subTitle.text = "Waiting..."
    }

    func requestAuthorization() {
        service.requestAuthorization { [weak self] result in
            switch result {
            case .success:
                // access is allowed
                self?.requestLocation()
            case .denied:
                // user denied access to geolocation
                self?.subTitle.text = "Denied..."
            case .failure:
                // user doesn't gave permission on his geolocation in the system dialog
                self?.subTitle.text = "Failure..."
            case .requesting:
                // system dialog is currently displayed
                self?.subTitle.text = "Requesting..."
            }
        }

    }

    func requestLocation() {
        service.getCurrentLocation { [weak self] result in
            switch result {
            case .success(let location):
                // do something usefull with user location
                self?.subTitle.text = "Current location is \(location)"
            case .denied:
                self?.subTitle.text = "User denied access to geolocation"
            case .error:
                self?.subTitle.text = "Some error ocured"
            }
        }
    }

}
