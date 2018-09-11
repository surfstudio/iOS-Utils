//
//  UIDevice+hasTapticEngine.swift
//  Utils
//
//  Created by Pavel Marinchenko on 9/10/18.
//  Copyright © 2018 Surf. All rights reserved.
//

extension UIDevice {
    var hasTapticEngine: Bool {
        return feedbackType == .taptic || hasHapticFeedback
    }
}
