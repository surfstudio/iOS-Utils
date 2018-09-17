//
//  UIDevice+hasHapticFeedback.swift
//  Utils
//
//  Created by Pavel Marinchenko on 9/10/18.
//  Copyright © 2018 Surf. All rights reserved.
//

extension UIDevice {
    // haptic feedback support guarantees that device supports taptic engine too.
    var hasHapticFeedback: Bool {
        return feedbackType == .haptic
    }
}
