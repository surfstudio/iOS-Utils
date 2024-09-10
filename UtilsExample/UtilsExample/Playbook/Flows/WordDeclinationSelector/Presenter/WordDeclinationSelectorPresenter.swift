//
//  WordDeclinationSelectorPresenter.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

final class WordDeclinationSelectorPresenter: WordDeclinationSelectorModuleOutput {

    // MARK: - WordDeclinationSelectorModuleOutput

    // MARK: - Properties

    weak var view: WordDeclinationSelectorViewInput?

}

// MARK: - WordDeclinationSelectorModuleInput

extension WordDeclinationSelectorPresenter: WordDeclinationSelectorModuleInput {
}

// MARK: - WordDeclinationSelectorViewOutput

extension WordDeclinationSelectorPresenter: WordDeclinationSelectorViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
