//
//  MoneyModelPresenter.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

final class MoneyModelPresenter: MoneyModelModuleOutput {

    // MARK: - MoneyModelModuleOutput

    // MARK: - Properties

    weak var view: MoneyModelViewInput?

}

// MARK: - MoneyModelModuleInput

extension MoneyModelPresenter: MoneyModelModuleInput {
}

// MARK: - MoneyModelViewOutput

extension MoneyModelPresenter: MoneyModelViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
