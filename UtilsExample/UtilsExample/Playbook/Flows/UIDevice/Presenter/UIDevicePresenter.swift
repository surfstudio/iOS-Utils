//
//  UIDevicePresenter.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 23/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

final class UIDevicePresenter: UIDeviceModuleOutput {

    // MARK: - UIDeviceModuleOutput

    // MARK: - Properties

    weak var view: UIDeviceViewInput?

}

// MARK: - UIDeviceModuleInput

extension UIDevicePresenter: UIDeviceModuleInput {
}

// MARK: - UIDeviceViewOutput

extension UIDevicePresenter: UIDeviceViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

}
