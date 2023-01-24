//
//  ActionableLabelViewInput.swift
//  UtilsExample
//
//  Created by Evgeny Vasilev on 24/06/2022.
//  Copyright © 2022 Surf. All rights reserved.
//

protocol ActionableLabelViewInput: AnyObject {
    /// Method for setup initial state of view
    func setupInitialState()
    func configure(with model: ActionableLabelViewController.Model)
}
