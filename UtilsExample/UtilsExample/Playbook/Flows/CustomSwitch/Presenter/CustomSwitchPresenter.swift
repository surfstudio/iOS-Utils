//
//  CustomSwitchPresenter.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 23/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

final class CustomSwitchPresenter: CustomSwitchModuleOutput {

    // MARK: - CustomSwitchModuleOutput

    // MARK: - Properties

    weak var view: CustomSwitchViewInput?

}

// MARK: - CustomSwitchModuleInput

extension CustomSwitchPresenter: CustomSwitchModuleInput {
}

// MARK: - CustomSwitchViewOutput

extension CustomSwitchPresenter: CustomSwitchViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
