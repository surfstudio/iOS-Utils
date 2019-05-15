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
        static let appSettingsUrl = UIApplication.openSettingsURLString
    }

    // MARK: - Public Methods

    public static func openAppSettings() {
        guard let url = URL(string: Constants.appSettingsUrl) else {
            return
        }
        openExpectedURL(url)
    }

    public static func openDeviceSettings() {
        guard let url = URL(string: Constants.deviceSettingsUrl) else {
            return
        }
        openExpectedURL(url)
    }

}

// MARK: - Private Methods

private extension SettingsRouter {

    static func openExpectedURL(_ url: URL) {
        guard UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}
