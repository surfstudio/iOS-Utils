//
//  QueryStringBuilderViewController.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 23/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit
import Utils

final class QueryStringBuilderViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var subTitle: UILabel!

    // MARK: - Properties

    var output: QueryStringBuilderViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - QueryStringBuilderViewInput

extension QueryStringBuilderViewController: QueryStringBuilderViewInput {

    func setupInitialState() {
        configureLabel()
    }

}

// MARK: - Private Methods

private extension QueryStringBuilderViewController {

    func configureLabel() {
        let dict: [String: Any] = ["key1": "value1", "key2": 2.15, "key3": true]
        let queryString = dict.toQueryString()
        subTitle.text = queryString
        subTitle.numberOfLines = 0
        subTitle.textAlignment = .center
        subTitle.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
