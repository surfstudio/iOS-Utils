//
//  UIView+BlurBuilder.swift
//  Utils
//
//  Created by Александр Чаусов on 10/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIView {

    /// Method allows you to add blur with custom color and style on needed view
    ///
    /// Example of usage:
    /// ```
    /// bluredView.addBlur(color: UIColor.white.withAlphaComponent(0.1), style: .light)
    /// ```
    ///
    /// - Parameters:
    ///   - color: Color of the blur effect
    ///   - style: Style of the blur effect, default value is .dark
    public func addBlur(color: UIColor, style: UIBlurEffect.Style = .dark) {
        self.backgroundColor = UIColor.clear

        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.contentView.backgroundColor = color
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.insertSubview(blurEffectView, at: 0)
    }
    
}
