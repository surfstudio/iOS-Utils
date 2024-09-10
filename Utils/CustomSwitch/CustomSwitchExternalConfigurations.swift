//
//  CustomSwitchExternalConfigurations.swift
//  Utils
//
//  Created by Artemii Shabanov on 13.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

/// Holds shadow parameters
public struct CSShadowConfiguration {
    let color: UIColor
    let offset: CGSize
    let radius: CGFloat
    let oppacity: Float

    public init(color: UIColor, offset: CGSize, radius: CGFloat, oppacity: Float) {
        self.color = color
        self.offset = offset
        self.radius = radius
        self.oppacity = oppacity
    }
}

/// Defines methods needed to apply color changes on CustomSwitch elements
public protocol CSColorConfiguration {
    /// Applies color changes for view
    func applyColor(for view: UIView)
}

/// Simple configuration color for CustomSwitch element
public struct CSSimpleColorConfiguration: CSColorConfiguration {
    let color: UIColor

    public func applyColor(for view: UIView) {
        view.backgroundColor = color
    }
    public init(color: UIColor) {
        self.color = color
    }
}

/// Gradient configuration for CustomSwitch element
public struct CSGradientColorConfiguration: CSColorConfiguration {
    let colors: [UIColor]
    let locations: [NSNumber]

    public func applyColor(for view: UIView) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.cornerRadius = view.layer.cornerRadius
        gradient.frame = view.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        view.layer.insertSublayer(gradient, at: 0)
    }
    public init(colors: [UIColor] = [], locations: [NSNumber] = []) {
        self.colors = colors
        self.locations = locations
    }
}
