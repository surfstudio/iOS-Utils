//
//  UIDeviceModuleConfigurator.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 23/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit

final class UIDeviceModuleConfigurator {

    func configure() -> (UIViewController, UIDeviceModuleOutput) {
        let view = UIDeviceViewController()
        let presenter = UIDevicePresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
