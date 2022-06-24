//
//  RouteMeasurerViewController.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit
import Utils
import CoreLocation

final class RouteMeasurerViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var subTitle: UILabel!

    // MARK: - Properties

    var output: RouteMeasurerViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - RouteMeasurerViewInput

extension RouteMeasurerViewController: RouteMeasurerViewInput {

    func setupInitialState() {
        configureLabel()
    }

}

// MARK: - Private Methods

private extension RouteMeasurerViewController {

    func configureLabel() {
        let firstCoordinate = CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423)
        let secondCoordinate = CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092)
        RouteMeasurer.calculateDistance(between: firstCoordinate, and: secondCoordinate) { [weak self] (distance) in
            guard let distance = distance else {
                return
            }
            self?.subTitle.text = RouteMeasurer.formatDistance(distance, meterPattern: "м", kilometrPatter: "км")
        }
        subTitle.numberOfLines = 0
        subTitle.textAlignment = .center
    }

}
