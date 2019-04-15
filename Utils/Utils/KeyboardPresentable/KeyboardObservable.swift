//
//  KeyboardObservable.swift
//  Utils
//
//  Created by Александр Чаусов on 16/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

/// This protocol carries out all the necessary actions for subscribing / unsubscribing from keyboard notifications.
/// You can use only this protocol, or you can use Common/FullKeyboardPresentable or you own implementation for getting
/// necessary parameters.
public protocol KeyboardObservable: class {

    /// Method for subscribing on keyboard notifications
    func subscribeOnKeyboardNotifications()

    /// Method for unsubscribing from keyboard notifications.
    /// You must call this method for unsubscriibing if you call subscribeOnKeyboardNotifications() method before
    func unsubscribeFromKeyboardNotifications()

    /// This method is called when the keyboard appears on the device screen
    func keyboardWillBeShown(notification: Notification)

    /// This method is called when the keyboard disappears from the device screen
    func keyboardWillBeHidden(notification: Notification)

}

public extension KeyboardObservable {

    // MARK: - Public Methods

    func subscribeOnKeyboardNotifications() {
        guard let notificationsObserver = KeyboardNotificationsObserverPool.shared.newObserver(for: self) else {
            // case when view already subscribed on notifications
            return
        }
        let center = NotificationCenter.default
        center.addObserver(notificationsObserver,
                           selector: #selector(KeyboardNotificationsObserver.keyboardWillBeShown(notification:)),
                           name: UIResponder.keyboardWillShowNotification,
                           object: nil)
        center.addObserver(notificationsObserver,
                           selector: #selector(KeyboardNotificationsObserver.keyboardWillBeHidden(notification:)),
                           name: UIResponder.keyboardWillHideNotification,
                           object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        KeyboardNotificationsObserverPool.shared.removeInvalid()
        KeyboardNotificationsObserverPool.shared.releaseObserver(for: self)
    }

}
