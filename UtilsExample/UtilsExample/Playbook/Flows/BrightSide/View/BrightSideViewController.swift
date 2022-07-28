//
//  BrightSideViewController.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit
import Utils

final class BrightSideViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var subTitle: UILabel!

    // MARK: - Properties

    var output: BrightSideViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - BrightSideViewInput

extension BrightSideViewController: BrightSideViewInput {

    func setupInitialState() {
        configureLabel()
    }

}

// MARK: - Private Methods

private extension BrightSideViewController {

    func configureLabel() {
        let text: String
        if BrightSide.isBright() {
            text = "Девайс чист как белый лист"
        } else {
            text = "На девайсе получен root доступ"
        }
        subTitle.text = text
        subTitle.numberOfLines = 0
        subTitle.textAlignment = .center
    }

}
