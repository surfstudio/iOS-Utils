//
//  SettingsRouter.swift
//  Utils
//
//  Created by Александр Чаусов on 02/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

/// Utils for opening various settings screens from the application
public final class SettingsRouter {

    // MARK: - Constants

    private enum Constants {
        static let deviceSettingsUrl = "App-prefs:root=General"
    }

    // MARK: - Internal Methods

    public static func openAppSettings() {
        if let url = URL(string: UIApplicationOpenSettingsURLString) {
            openExpectedURL(url)
        }
    }

    public static func openDeviceSettings() {
        if let url = URL(string: Constants.deviceSettingsUrl) {
            openExpectedURL(url)
        }
    }

}

// MARK: - Private Methods

private extension SettingsRouter {

    static func openExpectedURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
