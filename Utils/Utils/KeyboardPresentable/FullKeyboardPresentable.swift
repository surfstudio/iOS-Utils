//
//  FullKeyboardPresentable.swift
//  Utils
//
//  Created by Александр Чаусов on 16/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

/// This protocol allows you to get full keyboard parameters on keyboard appear/disappear.
/// But you have to use this protocol along with KeyboardObservable protocol.
public protocol FullKeyboardPresentable: class {

    /// This method is called when the keyboard appears on the device screen
    func keyboardWillBeShown(keyboardInfo: Notification.KeyboardInfo)

    /// This method is called when the keyboard disappears from the device screen
    func keyboardWillBeHidden(keyboardInfo: Notification.KeyboardInfo)

}

extension FullKeyboardPresentable where Self: KeyboardObservable {

    func keyboardWillBeShown(notification: Notification) {
        keyboardWillBeShown(keyboardInfo: notification.keyboardInfo)
    }

    func keyboardWillBeHidden(notification: Notification) {
        keyboardWillBeHidden(keyboardInfo: notification.keyboardInfo)
    }

}
