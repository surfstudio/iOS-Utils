//
//  SettingsRouterViewController.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit
import Utils

final class SettingsRouterViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var button: UIButton!

    // MARK: - Properties

    var output: SettingsRouterViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - SettingsRouterViewInput

extension SettingsRouterViewController: SettingsRouterViewInput {

    func setupInitialState() {
        configureButton()
    }

}

// MARK: - Private Methods

private extension SettingsRouterViewController {

    func configureButton() {
        button.layer.cornerRadius = 10
        button.addTarget(self,
                         action: #selector(self.didPressButton),
                         for: .touchUpInside)
    }

    @objc
    func didPressButton() {
        SettingsRouter.openAppSettings()
    }

}
