//
//  BlurBuilder.swift
//  Utils
//
//  Created by Александр Чаусов on 02/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

public final class BlurBuilder {

    /// Method allows you to add blur with custom color and style on needed view
    ///
    /// Example of usage:
    /// ```
    /// BlurBuilder.addBlur(on: bluredView, with: UIColor.white.withAlphaComponent(0.1), style: .light)
    /// ```
    ///
    /// - Parameters:
    ///   - view: View to which the blur will be added
    ///   - color: Color of the blur effect
    ///   - style: Style of the blur effect, default value is .dark
    public static func addBlur(on view: UIView, with color: UIColor, style: UIBlurEffect.Style = .dark) {
        view.backgroundColor = UIColor.clear

        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.contentView.backgroundColor = color
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.insertSubview(blurEffectView, at: 0)
    }

}
