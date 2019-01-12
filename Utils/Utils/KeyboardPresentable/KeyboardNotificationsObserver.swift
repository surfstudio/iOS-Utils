//
//  KeyboardNotificationsObserver.swift
//  Utils
//
//  Created by Александр Чаусов on 12/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

fileprivate enum Constants {
    static let animationDuration: TimeInterval = 0.25
}

/// An instance of this class is responsible for handling notifications when the keyboard appears and disappears.
/// Its necessity is caused by the fact that in the protocol extension you cannot declare methods with the @objc identifier.
final class KeyboardNotificationsObserver {

    // MARK: - Private Properties

    private weak var view: KeyboardPresentable?

    // MARK: - Initialization

    init(view: KeyboardPresentable) {
        self.view = view
    }

    // MARK: - Internal Methods

    @objc
    func keyboardWillBeShown(notification: Notification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        let duration = animationDuration(from: notification)
        view?.keyboardWillBeShown(keyboardHeight: keyboardHeight, duration: duration)
    }

    @objc
    func keyboardWillBeHidden(notification: Notification) {
        let duration = animationDuration(from: notification)
        view?.keyboardWillBeHidden(duration: duration)
    }

}

// MARK: - Private Methods

private extension KeyboardNotificationsObserver {

    func animationDuration(from notification: Notification) -> TimeInterval {
        guard let duration = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSNumber else {
            return Constants.animationDuration
        }
        return TimeInterval(truncating: duration)
    }

}
