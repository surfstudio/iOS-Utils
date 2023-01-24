//
//  ActionableLabelModuleConfigurator.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit

final class ActionableLabelModuleConfigurator {

    func configure() -> (UIViewController, ActionableLabelModuleOutput) {
        let view = ActionableLabelViewController()
        let presenter = ActionableLabelPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
