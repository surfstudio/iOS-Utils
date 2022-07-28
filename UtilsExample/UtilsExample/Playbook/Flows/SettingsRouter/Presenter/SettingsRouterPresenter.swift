//
//  SettingsRouterPresenter.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

final class SettingsRouterPresenter: SettingsRouterModuleOutput {

    // MARK: - SettingsRouterModuleOutput

    // MARK: - Properties

    weak var view: SettingsRouterViewInput?

}

// MARK: - SettingsRouterModuleInput

extension SettingsRouterPresenter: SettingsRouterModuleInput {
}

// MARK: - SettingsRouterViewOutput

extension SettingsRouterPresenter: SettingsRouterViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
