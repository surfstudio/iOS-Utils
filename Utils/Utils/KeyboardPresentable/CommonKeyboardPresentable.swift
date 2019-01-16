//
//  CommonKeyboardPresentable.swift
//  Utils
//
//  Created by Александр Чаусов on 16/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

fileprivate enum Constants {
    static let animationDuration: TimeInterval = 0.25
}

/// This protocol allows you to get plain keyboard parameters on keyboard appear/disappear.
/// But you have to use this protocol along with KeyboardObservable protocol.
public protocol CommonKeyboardPresentable: class {

    /// This method is called when the keyboard appears on the device screen
    func keyboardWillBeShown(keyboardHeight: CGFloat, duration: TimeInterval)

    /// This method is called when the keyboard disappears from the device screen
    func keyboardWillBeHidden(duration: TimeInterval)

}

extension CommonKeyboardPresentable where Self: KeyboardObservable {

    func keyboardWillBeShown(notification: Notification) {
        guard let keyboardHeight = notification.keyboardInfo.frameEnd?.height else {
            return
        }
        let duration = notification.keyboardInfo.animationDuration ?? Constants.animationDuration
        keyboardWillBeShown(keyboardHeight: keyboardHeight, duration: duration)
    }

    func keyboardWillBeHidden(notification: Notification) {
        let duration = notification.keyboardInfo.animationDuration ?? Constants.animationDuration
        keyboardWillBeHidden(duration: duration)
    }

}
