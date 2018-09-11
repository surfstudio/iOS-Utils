//
//  UIDevice+feedbackType.swift
//  Utils
//
//  Created by Pavel Marinchenko on 9/11/18.
//  Copyright © 2018 Surf. All rights reserved.
//

extension UIDevice {
    enum FeedbackType: Int {
        case base = 0
        case taptic
        case haptic
    }

    var feedbackType: FeedbackType {
        if let fsl = UIDevice.current.value(forKey: "_feedbackSupportLevel") as? Int, let feedbackSupportLevel = Int(fsl) {
            return FeedbackType(rawValue: feedbackSupportLevel) ?? .base
        }
        return .base
    }
}
