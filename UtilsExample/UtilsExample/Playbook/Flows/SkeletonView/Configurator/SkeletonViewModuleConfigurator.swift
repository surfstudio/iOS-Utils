//
//  SkeletonViewModuleConfigurator.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit

final class SkeletonViewModuleConfigurator {

    func configure() -> (UIViewController, SkeletonViewModuleOutput) {
        let view = SkeletonViewViewController()
        let presenter = SkeletonViewPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
