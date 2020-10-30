//
//  ErrorView.swift
//  Utils
//
//  Created by Никита Гагаринов on 19.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

/// Protocol for implementing custom ErrorView/EmptyView
public protocol ErrorView: UIView {
    var state: ErrorViewState { get }
    var onAction: ((ErrorViewState) -> Void)? { get set }

    func configure(info: ViewStateInfo, config: ViewStateConfiguration, state: ErrorViewState)
}
