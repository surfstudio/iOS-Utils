//
//  SkeletonViewPresenter.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

final class SkeletonViewPresenter: SkeletonViewModuleOutput {

    // MARK: - SkeletonViewModuleOutput

    // MARK: - Properties

    weak var view: SkeletonViewViewInput?

}

// MARK: - SkeletonViewModuleInput

extension SkeletonViewPresenter: SkeletonViewModuleInput {
}

// MARK: - SkeletonViewViewOutput

extension SkeletonViewPresenter: SkeletonViewViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
