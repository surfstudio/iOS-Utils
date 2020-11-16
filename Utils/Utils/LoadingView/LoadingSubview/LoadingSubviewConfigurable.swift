//
//  LoadingSubviewConfigurable.swift
//  Utils
//
//  Created by Никита Гагаринов on 18.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

public protocol LoadingSubviewConfigurable: UIView {
    associatedtype Model

    /// Changes offsets or required parameters
    func configure(model: Model)
}

extension LoadingSubviewConfigurable where Model == DefaultLoadingModel {
    func configure(model: Model) { }
}
