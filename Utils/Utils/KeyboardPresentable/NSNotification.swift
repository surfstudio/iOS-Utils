//
//  NSNotification.swift
//  Utils
//
//  Created by Александр Чаусов on 16/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension Notification {

    /// Instance of this structure keeps info about keyboard from notification
    public struct KeyboardInfo {
        var frame: CGRect?
        var animationCurve: UInt?
        var animationDuration: Double?
        var frameEnd: NSValue?
    }

    // MARK: - Properties

    var keyboardInfo: KeyboardInfo {
        return KeyboardInfo(frame: keyboardFrame,
                            animationCurve: keyboradAnimationCurve,
                            animationDuration: keyboardAnimationDuration,
                            frameEnd: keyboardFrameEnd)
    }

    // MARK: - Private Properties

    private var keyboardFrame: CGRect? {
        return userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
    }

    private var keyboradAnimationCurve: UInt? {
        return userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? UInt
    }

    private var keyboardAnimationDuration: Double? {
        return userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
    }

    private var keyboardFrameEnd: NSValue? {
        return userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
    }

}
