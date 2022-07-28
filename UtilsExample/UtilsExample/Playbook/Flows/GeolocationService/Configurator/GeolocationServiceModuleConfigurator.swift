//
//  GeolocationServiceModuleConfigurator.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit

final class GeolocationServiceModuleConfigurator {

    func configure() -> (UIViewController, GeolocationServiceModuleOutput) {
        let view = GeolocationServiceViewController()
        let presenter = GeolocationServicePresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
