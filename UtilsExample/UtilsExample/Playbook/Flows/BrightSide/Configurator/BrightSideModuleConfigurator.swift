//
//  BrightSideModuleConfigurator.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit

final class BrightSideModuleConfigurator {

    func configure() -> (UIViewController, BrightSideModuleOutput) {
        let view = BrightSideViewController()
        let presenter = BrightSidePresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
