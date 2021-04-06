//
//  DigitFieldStyle.swift
//  Utils
//
//  Created by Anton Dryakhlykh on 16.10.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

public struct DigitFieldStyle {
    public let font: UIFont
    public let activeTextColor: UIColor
    public let inactiveTextColor: UIColor
    public let errorTextColor: UIColor
    public let activeBottomLineColor: UIColor
    public let inactiveBottomLineColor: UIColor
    public let errorBottomLineColor: UIColor

    public init(font: UIFont,
                activeTextColor: UIColor,
                inactiveTextColor: UIColor,
                errorTextColor: UIColor,
                activeBottomLineColor: UIColor,
                inactiveBottomLineColor: UIColor,
                errorBottomLineColor: UIColor) {

        self.font = font
        self.activeTextColor = activeTextColor
        self.inactiveTextColor = inactiveTextColor
        self.errorTextColor = errorTextColor
        self.activeBottomLineColor = activeBottomLineColor
        self.inactiveBottomLineColor = inactiveBottomLineColor
        self.errorBottomLineColor = errorBottomLineColor
    }

    public init() {
        self.font = UIFont.systemFont(ofSize: 17.0)
        self.activeTextColor = UIColor.blue
        self.inactiveTextColor = UIColor.black
        self.errorTextColor = UIColor.red
        self.activeBottomLineColor = UIColor.blue
        self.inactiveBottomLineColor = UIColor.black
        self.errorBottomLineColor = UIColor.red
    }
}
