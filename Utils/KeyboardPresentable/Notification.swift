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
        public var frameBegin: CGRect?
        public var animationCurve: UInt?
        public var animationDuration: Double?
        public var frameEnd: CGRect?
    }

    // MARK: - Public Properties

    public var keyboardInfo: KeyboardInfo {
        return KeyboardInfo(frameBegin: keyboardFrameBegin,
                            animationCurve: keyboradAnimationCurve,
                            animationDuration: keyboardAnimationDuration,
                            frameEnd: keyboardFrameEnd)
    }

    // MARK: - Private Properties

    private var keyboardFrameBegin: CGRect? {
        return userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect
    }

    private var keyboradAnimationCurve: UInt? {
        return userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
    }

    private var keyboardAnimationDuration: Double? {
        return userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
    }

    private var keyboardFrameEnd: CGRect? {
        return userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    }

}
