//
//  ActionableLabelPresenter.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

final class ActionableLabelPresenter: ActionableLabelModuleOutput {

    // MARK: - Properties

    weak var view: ActionableLabelViewInput?

}

// MARK: - ActionableLabelModuleInput

extension ActionableLabelPresenter: ActionableLabelModuleInput {
}

// MARK: - ActionableLabelViewOutput

extension ActionableLabelPresenter: ActionableLabelViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        view?.configure(with: [
            (text: "Start sentences ", didSelect: nil),
            (text: "link text", didSelect: {
                print("link selected")
            }),
            (text: " end sentences.", didSelect: nil)
        ])
    }

}
