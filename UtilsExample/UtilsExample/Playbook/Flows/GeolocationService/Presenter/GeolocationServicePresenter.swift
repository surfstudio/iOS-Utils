//
//  GeolocationServicePresenter.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

final class GeolocationServicePresenter: GeolocationServiceModuleOutput {

    // MARK: - GeolocationServiceModuleOutput

    // MARK: - Properties

    weak var view: GeolocationServiceViewInput?

}

// MARK: - GeolocationServiceModuleInput

extension GeolocationServicePresenter: GeolocationServiceModuleInput {
}

// MARK: - GeolocationServiceViewOutput

extension GeolocationServicePresenter: GeolocationServiceViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
