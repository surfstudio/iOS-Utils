//
//  KeyboardPresentablePresenter.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

final class KeyboardPresentablePresenter: KeyboardPresentableModuleOutput {

    // MARK: - KeyboardPresentableModuleOutput

    // MARK: - Properties

    weak var view: KeyboardPresentableViewInput?

}

// MARK: - KeyboardPresentableModuleInput

extension KeyboardPresentablePresenter: KeyboardPresentableModuleInput {
}

// MARK: - KeyboardPresentableViewOutput

extension KeyboardPresentablePresenter: KeyboardPresentableViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
