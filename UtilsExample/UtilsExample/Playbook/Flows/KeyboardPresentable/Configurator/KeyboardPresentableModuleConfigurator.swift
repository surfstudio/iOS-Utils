//
//  KeyboardPresentableModuleConfigurator.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit

final class KeyboardPresentableModuleConfigurator {

    func configure() -> (UIViewController, KeyboardPresentableModuleOutput) {
        let view = KeyboardPresentableViewController()
        let presenter = KeyboardPresentablePresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
