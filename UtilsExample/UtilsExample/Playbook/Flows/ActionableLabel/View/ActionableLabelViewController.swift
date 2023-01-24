//
//  ActionableLabelViewController.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit
import Utils
import Autolocalizable

final class ActionableLabelViewController: UIViewController {

    // MARK: - Nested types

    public typealias Model = [(text: LocalizableStringItem, didSelect: (() -> Void)?)]

    // MARK: - IBOutlets

    @IBOutlet private weak var subTitle: ActionableLabel!

    // MARK: - Properties

    var output: ActionableLabelViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - ActionableLabelViewInput

extension ActionableLabelViewController: ActionableLabelViewInput {

    func setupInitialState() {
        configureLabel()
    }

    func configure(with model: Model) {
        subTitle.clear()
        model.forEach { part in
            let isLink = part.didSelect != nil
            subTitle.append(
                text: part.text,
                attributes: isLink ? [.font(.systemFont(ofSize: 20)), .foregroundColor(.link)] : [],
                action: {
                    part.didSelect?()
                }
            )
        }
    }

}

// MARK: - Private Methods

private extension ActionableLabelViewController {

    func configureLabel() {
        subTitle.globalAttributes = [
            .lineSpacing(0),
            .foregroundColor(.black),
            .font(.systemFont(ofSize: 14))
        ]
    }

}
