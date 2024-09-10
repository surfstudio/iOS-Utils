//
//  CustomSwitchModuleConfigurator.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 23/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit

final class CustomSwitchModuleConfigurator {

    func configure() -> (UIViewController, CustomSwitchModuleOutput) {
        let view = CustomSwitchViewController()
        let presenter = CustomSwitchPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
