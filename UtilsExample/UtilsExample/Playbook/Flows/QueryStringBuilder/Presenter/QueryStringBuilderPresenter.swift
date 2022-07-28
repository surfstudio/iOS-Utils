//
//  QueryStringBuilderPresenter.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 23/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

final class QueryStringBuilderPresenter: QueryStringBuilderModuleOutput {

    // MARK: - QueryStringBuilderModuleOutput

    // MARK: - Properties

    weak var view: QueryStringBuilderViewInput?

}

// MARK: - QueryStringBuilderModuleInput

extension QueryStringBuilderPresenter: QueryStringBuilderModuleInput {
}

// MARK: - QueryStringBuilderViewOutput

extension QueryStringBuilderPresenter: QueryStringBuilderViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
