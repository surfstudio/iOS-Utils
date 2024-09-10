//
//  KeyboardNotificationsObserverPool.swift
//  Utils
//
//  Created by Александр Чаусов on 16/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

/// Pool of observers. Implemented as singltone for retain reference on observers.
final class KeyboardNotificationsObserverPool {

    // MARK: - Properties

    static let shared = KeyboardNotificationsObserverPool()

    // MARK: - Private Properties

    private var observers: [KeyboardNotificationsObserver] = []

    // MARK: - Internal Methods

    /// Returns new observer for view or nil if observer already exist
    func newObserver(for view: KeyboardObservable) -> KeyboardNotificationsObserver? {
        guard observers.first(where: { $0.isLinked(to: view) }) == nil else {
            return nil
        }
        let observer = KeyboardNotificationsObserver(view: view)
        observers.append(observer)
        return observer
    }

    /// Removes invalid observers, which have no view
    func removeInvalid() {
        for observer in observers.filter({ $0.isInvalid }) {
            NotificationCenter.default.removeObserver(observer)
        }
        observers.removeAll(where: { $0.isInvalid })
    }

    /// Releases observer for given view
    func releaseObserver(for view: KeyboardObservable) {
        for observer in observers.filter({ $0.isLinked(to: view) }) {
            NotificationCenter.default.removeObserver(observer)
        }
        observers.removeAll(where: { $0.isLinked(to: view) })
    }

}
