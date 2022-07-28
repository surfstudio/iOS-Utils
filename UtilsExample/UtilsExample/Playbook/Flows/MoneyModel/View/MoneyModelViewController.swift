//
//  MoneyModelViewController.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit
import Utils

final class MoneyModelViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var subTitle: UILabel!

    // MARK: - Properties

    var output: MoneyModelViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - MoneyModelViewInput

extension MoneyModelViewController: MoneyModelViewInput {

    func setupInitialState() {
        configureLabel()
    }

}

// MARK: - Private Methods

private extension MoneyModelViewController {

    func configureLabel() {
        let text = [
            MoneyModel(decimal: 10, digit: 0).asString(),
            "\n",
            MoneyModel(decimal: 10, digit: 9).asString(),
            "\n",
            MoneyModel(decimal: 10, digit: 99).asString()
        ]
        subTitle.text = text.reduce("", +)
        subTitle.numberOfLines = 0
        subTitle.textAlignment = .center
    }

}
