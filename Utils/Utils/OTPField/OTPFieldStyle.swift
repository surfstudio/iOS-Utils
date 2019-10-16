//
//  OTPFieldStyle.swift
//  Utils
//
//  Created by Anton Dryakhlykh on 16.10.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

public struct OTPFieldStyle {
    public let digitStyle: DigitFieldStyle
    public let errorTextColor: UIColor
    public let errorFont: UIFont

    public init(digitStyle: DigitFieldStyle, errorTextColor: UIColor, errorFont: UIFont) {
        self.digitStyle = digitStyle
        self.errorTextColor = errorTextColor
        self.errorFont = errorFont
    }

    public init() {
        self.digitStyle = DigitFieldStyle()
        self.errorTextColor = .red
        self.errorFont = UIFont.systemFont(ofSize: 17.0)
    }
}
