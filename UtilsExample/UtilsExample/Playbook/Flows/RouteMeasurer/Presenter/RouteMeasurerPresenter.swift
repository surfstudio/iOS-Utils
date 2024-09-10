//
//  RouteMeasurerPresenter.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

final class RouteMeasurerPresenter: RouteMeasurerModuleOutput {

    // MARK: - RouteMeasurerModuleOutput

    // MARK: - Properties

    weak var view: RouteMeasurerViewInput?

}

// MARK: - RouteMeasurerModuleInput

extension RouteMeasurerPresenter: RouteMeasurerModuleInput {
}

// MARK: - RouteMeasurerViewOutput

extension RouteMeasurerPresenter: RouteMeasurerViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
