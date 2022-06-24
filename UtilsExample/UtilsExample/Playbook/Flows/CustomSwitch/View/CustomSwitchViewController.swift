//
//  CustomSwitchViewController.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 23/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit
import Utils

final class CustomSwitchViewController: UIViewController {

    @IBOutlet private weak var switchContainer: UIView!

    // MARK: - Properties

    var output: CustomSwitchViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - CustomSwitchViewInput

extension CustomSwitchViewController: CustomSwitchViewInput {

    func setupInitialState() {
        configureSwitch()
    }

}

// MARK: - Private Methods

private extension CustomSwitchViewController {

    func configureSwitch() {
        let customSwitch = CustomSwitch(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        customSwitch.layoutConfiguration = .init(padding: 1, spacing: 3, cornerRatio: 0.5)
        customSwitch.colorsConfiguration = .init(
            offColorConfiguraion: CSSimpleColorConfiguration(color: .white),
            onColorConfiguraion: CSSimpleColorConfiguration(color: .green),
            thumbColorConfiguraion: CSGradientColorConfiguration(
                colors: [.lightGray, .yellow],
                locations: [0, 1]
            )
        )
        customSwitch.thumbConfiguration = .init(
            cornerRatio: 0.5,
            shadowConfiguration: .init(
                color: .black, offset: CGSize(),
                radius: 5, oppacity: 0.1
            )
        )
        customSwitch.animationsConfiguration = .init(duration: 0.1, usingSpringWithDamping: 0.7)

        customSwitch.setOn(true, animated: false)
        switchContainer.addSubview(customSwitch)
    }

}
