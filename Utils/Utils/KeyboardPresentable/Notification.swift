//
//  Notification.swift
//  Utils
//
//  Created by Александр Чаусов on 16/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension Notification {

    /// Instance of this structure keeps info about keyboard from notification
    public struct KeyboardInfo {
        var frameBegin: CGRect?
        var animationCurve: UInt?
        var animationDuration: Double?
        var frameEnd: CGRect?
    }

    // MARK: - Properties

    var keyboardInfo: KeyboardInfo {
        return KeyboardInfo(frameBegin: keyboardFrameBegin,
                            animationCurve: keyboradAnimationCurve,
                            animationDuration: keyboardAnimationDuration,
                            frameEnd: keyboardFrameEnd)
    }

    // MARK: - Private Properties

    private var keyboardFrameBegin: CGRect? {
        return userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect
    }

    private var keyboradAnimationCurve: UInt? {
        return userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? UInt
    }

    private var keyboardAnimationDuration: Double? {
        return userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
    }

    private var keyboardFrameEnd: CGRect? {
        return userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
    }

}
