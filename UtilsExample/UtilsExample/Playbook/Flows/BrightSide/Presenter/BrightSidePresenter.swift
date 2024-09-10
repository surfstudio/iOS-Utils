//
//  BrightSidePresenter.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

final class BrightSidePresenter: BrightSideModuleOutput {

    // MARK: - BrightSideModuleOutput

    // MARK: - Properties

    weak var view: BrightSideViewInput?

}

// MARK: - BrightSideModuleInput

extension BrightSidePresenter: BrightSideModuleInput {
}

// MARK: - BrightSideViewOutput

extension BrightSidePresenter: BrightSideViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
