//
//  ActionableLabelPresenter.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import Autolocalizable

final class ActionableLabelPresenter: ActionableLabelModuleOutput {

    // MARK: - BrightSideModuleOutput

    // MARK: - Properties

    weak var view: ActionableLabelViewInput?

}

// MARK: - BrightSideModuleInput

extension ActionableLabelPresenter: ActionableLabelModuleInput {
}

// MARK: - BrightSideViewOutput

extension ActionableLabelPresenter: ActionableLabelViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        view?.configure(with: [
            (text: LocalizableStringItem("Start sentences "), didSelect: nil),
            (text: LocalizableStringItem("link text"), didSelect: {
                print("link selected")
            }),
            (text: LocalizableStringItem(" end sentences."), didSelect: nil)
        ])
    }

}
