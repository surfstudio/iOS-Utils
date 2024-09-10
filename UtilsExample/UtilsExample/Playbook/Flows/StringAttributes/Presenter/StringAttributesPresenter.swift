//
//  StringAttributesPresenter.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 23/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

final class StringAttributesPresenter: StringAttributesModuleOutput {

    // MARK: - StringAttributesModuleOutput

    // MARK: - Properties

    weak var view: StringAttributesViewInput?

}

// MARK: - StringAttributesModuleInput

extension StringAttributesPresenter: StringAttributesModuleInput {
}

// MARK: - StringAttributesViewOutput

extension StringAttributesPresenter: StringAttributesViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
