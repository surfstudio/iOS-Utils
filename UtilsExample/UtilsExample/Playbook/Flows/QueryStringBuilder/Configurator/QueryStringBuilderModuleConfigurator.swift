//
//  QueryStringBuilderModuleConfigurator.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 23/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit

final class QueryStringBuilderModuleConfigurator {

    func configure() -> (UIViewController, QueryStringBuilderModuleOutput) {
        let view = QueryStringBuilderViewController()
        let presenter = QueryStringBuilderPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
