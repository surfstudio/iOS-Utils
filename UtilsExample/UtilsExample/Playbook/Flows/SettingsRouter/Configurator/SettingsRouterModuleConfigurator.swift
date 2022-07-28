//
//  SettingsRouterModuleConfigurator.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit

final class SettingsRouterModuleConfigurator {

    func configure() -> (UIViewController, SettingsRouterModuleOutput) {
        let view = SettingsRouterViewController()
        let presenter = SettingsRouterPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
