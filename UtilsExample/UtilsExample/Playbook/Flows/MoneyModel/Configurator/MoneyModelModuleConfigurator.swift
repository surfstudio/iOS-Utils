//
//  MoneyModelModuleConfigurator.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit

final class MoneyModelModuleConfigurator {

    func configure() -> (UIViewController, MoneyModelModuleOutput) {
        let view = MoneyModelViewController()
        let presenter = MoneyModelPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
