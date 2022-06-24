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
        let correctForm1 = WordDeclinationSelector.declineWord(
            for: 6,
            from: WordDeclinations("день", "дня", "дней")
        )
        let correctForm2 = WordDeclinationSelector.declineWord(
            for: 1,
            from: WordDeclinations("день", "дня", "дней")
        )
        let correctForm3 = WordDeclinationSelector.declineWord(
            for: 2,
            from: WordDeclinations("день", "дня", "дней")
        )
        subTitle.text = "6 \(correctForm1), \n1 \(correctForm2), \n2 \(correctForm3)"
        subTitle.numberOfLines = 0
        subTitle.textAlignment = .center
    }

}
