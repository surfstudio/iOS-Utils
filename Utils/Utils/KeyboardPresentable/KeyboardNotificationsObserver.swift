//
//  KeyboardNotificationsObserver.swift
//  Utils
//
//  Created by Александр Чаусов on 12/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

/// An instance of this class is responsible for handling notifications when the keyboard appears and disappears.
/// Its necessity is caused by the fact that in the protocol extension you cannot declare methods with
/// the @objc identifier.
final class KeyboardNotificationsObserver {

    // MARK: - Private Properties

    private weak var view: KeyboardObservable?

    // MARK: - Properties

    var isInvalid: Bool {
        return view == nil
    }

    // MARK: - Initialization

    init(view: KeyboardObservable) {
        self.view = view
    }

    // MARK: - Internal Methods

    @objc
    func keyboardWillBeShown(notification: Notification) {
        view?.keyboardWillBeShown(notification: notification)
    }

    @objc
    func keyboardWillBeHidden(notification: Notification) {
        view?.keyboardWillBeHidden(notification: notification)
    }

    @objc
    func keyboardWasShown(notification: Notification) {
        view?.keyboardWasShown(notification: notification)
    }

    @objc
    func keyboardWasHidden(notification: Notification) {
        view?.keyboardWasHidden(notification: notification)
    }

    func isLinked(to view: KeyboardObservable) -> Bool {
        guard let guardedView = self.view else {
            return false
        }
        return guardedView === view
    }

}
