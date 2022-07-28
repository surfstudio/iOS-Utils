//
//  StringAttributesViewController.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 23/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

import UIKit
import Utils

final class StringAttributesViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var subTitle: UILabel!

    // MARK: - Properties

    var output: StringAttributesViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

}

// MARK: - StringAttributesViewInput

extension StringAttributesViewController: StringAttributesViewInput {

    func setupInitialState() {
        configureLabel()
    }

}

// MARK: - Private Methods

private extension StringAttributesViewController {

    func configureLabel() {
        let globalSttributes: [StringAttribute] = [
            .font(.systemFont(ofSize: 14)),
            .foregroundColor(.black)
        ]
        let attributedString = StringBuilder(globalAttributes: globalSttributes)
            .add(.string("Title"))
            .add(.delimeterWithString(repeatedDelimeter: .init(type: .space),
                                      string: "blue"),
                 with: [.foregroundColor(.blue)])
            .add(.delimeterWithString(repeatedDelimeter: .init(type: .lineBreak),
                                      string: "Base style on new line"))
            .add(.delimeterWithString(repeatedDelimeter: .init(type: .space),
                                      string: "last word with it's own style"),
                 with: [.font(.boldSystemFont(ofSize: 16)), .foregroundColor(.red)])
            .value
        subTitle.attributedText = attributedString
        subTitle.numberOfLines = 0
        subTitle.textAlignment = .center
    }

}
