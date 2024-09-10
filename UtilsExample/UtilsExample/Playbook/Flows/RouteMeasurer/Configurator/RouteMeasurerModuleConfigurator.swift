//
//  RouteMeasurerModuleConfigurator.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit

final class RouteMeasurerModuleConfigurator {

    func configure() -> (UIViewController, RouteMeasurerModuleOutput) {
        let view = RouteMeasurerViewController()
        let presenter = RouteMeasurerPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
