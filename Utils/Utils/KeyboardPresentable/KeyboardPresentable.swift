//
//  KeyboardPresentable.swift
//  Utils
//
//  Created by Александр Чаусов on 12/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

fileprivate enum AssociatedKeys {
    static var observer: UInt8 = 0
}

/// This protocol carries out all the necessary actions for subscribing / unsubscribing from keyboard notifications, as well as calculating the keyboard height and animation time
public protocol KeyboardPresentable: class {

    /// Method for subscribing on keyboard notifications
    func subscribeOnKeyboardNotifications()

    /// Method for unsubscribing from keyboard notifications
    func unsubscribeFromKeyboardNotifications()

    /// This method is called when the keyboard appears on the device screen
    func keyboardWillBeShown(keyboardHeight: CGFloat, duration: TimeInterval)

    /// This method is called when the keyboard disappears from the device screen
    func keyboardWillBeHidden(duration: TimeInterval)

}

extension KeyboardPresentable where Self: UIViewController {

    // MARK: - Private Properties

    private var observer: KeyboardNotificationsObserver? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.observer) as? KeyboardNotificationsObserver
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.observer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // MARK: - Public Methods

    func subscribeOnKeyboardNotifications() {
        let notificationsObserver = KeyboardNotificationsObserver(view: self)
        observer = notificationsObserver

        let center = NotificationCenter.default
        center.addObserver(notificationsObserver,
                           selector: #selector(KeyboardNotificationsObserver.keyboardWillBeShown(notification:)),
                           name: NSNotification.Name.UIKeyboardWillShow,
                           object: nil)
        center.addObserver(notificationsObserver,
                           selector: #selector(KeyboardNotificationsObserver.keyboardWillBeHidden(notification:)),
                           name: NSNotification.Name.UIKeyboardWillShow,
                           object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        guard let observer = observer else {
            return
        }
        NotificationCenter.default.removeObserver(observer)
    }

    func keyboardWillBeShown(keyboardHeight: CGFloat, duration: TimeInterval) {}

    func keyboardWillBeHidden(duration: TimeInterval) {}

}
