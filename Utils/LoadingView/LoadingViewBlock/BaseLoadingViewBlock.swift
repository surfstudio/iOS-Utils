//
//  LoadingViewBlock.swift
//  Utils
//
//  Created by Никита Гагаринов on 19.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

public final class BaseLoadingViewBlock<Subview: LoadingSubview & LoadingSubviewConfigurable>: LoadingViewBlock {

    // MARK: - Public Properties

    public let repeatCount: Int
    public let model: Subview.Model

    // MARK: - Private Properties

    private lazy var subviews: [LoadingSubview] = {
        return produce()
    }()

    // MARK: - Initialization

    public init(model: Subview.Model, repeatCount: Int = 1) {
        self.model = model
        self.repeatCount = repeatCount
    }

    // MARK: - Public Methods

    public func configure(color: UIColor) {
        subviews.forEach { $0.configure(color: color) }
    }

    public func reconfigure(repeatCount: Int) -> BaseLoadingViewBlock<Subview> {
        return BaseLoadingViewBlock<Subview>(model: model, repeatCount: repeatCount)
    }

    public func getSubviews() -> [LoadingSubview] {
        return subviews
    }

}

// MARK: - Private Methods

private extension BaseLoadingViewBlock {

    func produce() -> [LoadingSubview] {
        return (0..<repeatCount).map { _ in
            let subview = Subview()
            subview.configure(model: model)
            return subview
        }
    }

}
