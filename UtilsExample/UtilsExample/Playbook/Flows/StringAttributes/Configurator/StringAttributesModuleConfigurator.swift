//
//  StringAttributesModuleConfigurator.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 23/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit

final class StringAttributesModuleConfigurator {

    func configure() -> (UIViewController, StringAttributesModuleOutput) {
        let view = StringAttributesViewController()
        let presenter = StringAttributesPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
