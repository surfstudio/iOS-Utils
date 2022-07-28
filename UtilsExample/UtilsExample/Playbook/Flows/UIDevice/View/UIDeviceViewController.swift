//
//  UIDeviceViewController.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 23/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit
import Utils

final class UIDeviceViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var subTitle: UILabel!

    // MARK: - Properties

    var output: UIDeviceViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - UIDeviceViewInput

extension UIDeviceViewController: UIDeviceViewInput {

    func setupInitialState() {
        configureLabe()
    }

}

// MARK: - Private Methods

private extension UIDeviceViewController {

    func configureLabe() {
        let text = [
            "SmallPhone: \(UIDevice.isSmallPhone)",
            "\nNormalPhone: \(UIDevice.isNormalPhone)",
            "\nXPhone: \(UIDevice.isXPhone)",
            "\nPad: \(UIDevice.isPad)",
            "\nDevice version: \(Device.version())",
            "\nIs simulator: \(Device.isSimulator())"
        ]
        subTitle.text = text.reduce("", +)
        subTitle.numberOfLines = 0
        subTitle.textAlignment = .center
    }
}
