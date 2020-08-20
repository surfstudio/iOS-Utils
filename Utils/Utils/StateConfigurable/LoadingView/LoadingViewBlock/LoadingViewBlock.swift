//
//  LoadingViewBlock.swift
//  Utils
//
//  Created by Никита Гагаринов on 19.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

final class LoadingViewBlock<Subview: LoadingSubviewAbstract & LoadingSubviewConfigurable>: LoadingViewBlockAbstract {

    // MARK: - Public Properties

    public let repeatCount: Int
    public let model: Subview.Model

    // MARK: - Private Properties

    private lazy var subviews: [LoadingSubviewAbstract] = {
        return produce()
    }()

    // MARK: - Initialization

    init(model: Subview.Model, repeatCount: Int = 1) {
        self.model = model
        self.repeatCount = repeatCount
    }

    // MARK: - Public Methods

    public func configure(color: UIColor) {
        subviews.forEach { $0.configure(color: color) }
    }

    public func reconfigure(repeatCount: Int) -> LoadingViewBlock<Subview> {
        return LoadingViewBlock<Subview>(model: model, repeatCount: repeatCount)
    }

    public func getSubviews() -> [LoadingSubviewAbstract] {
        return subviews
    }

}

// MARK: - Private Methods

private extension LoadingViewBlock {

    func produce() -> [LoadingSubviewAbstract] {
        return (0..<repeatCount).map { _ in
            let subview = Subview()
            subview.configure(model: model)
            return subview
        }
    }

}
