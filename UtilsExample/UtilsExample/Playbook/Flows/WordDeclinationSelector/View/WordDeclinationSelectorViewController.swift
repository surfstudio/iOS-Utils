//
//  WordDeclinationSelectorViewController.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit
import Utils

final class WordDeclinationSelectorViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var subTitle: UILabel!

    // MARK: - Properties

    var output: WordDeclinationSelectorViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - WordDeclinationSelectorViewInput

extension WordDeclinationSelectorViewController: WordDeclinationSelectorViewInput {

    func setupInitialState() {
        configureLabel()
    }

}

// MARK: - Private Methods

private extension WordDeclinationSelectorViewController {

    func configureLabel() {
        let declinations = WordDeclinations("день", "дня", "дней")
        let example = [1, 2, 6]
            .map { number -> String in
                let form = WordDeclinationSelector.declineWord(for: number, from: declinations)
                return "\(number) \(form)"
            }.joined(separator: "\n")
        subTitle.text = example
        subTitle.numberOfLines = 0
        subTitle.textAlignment = .center
    }

}
