//
//  BrightSide.swift
//  Utils
//
//  Created by Vlad Krupenko on 05.09.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

import Foundation
import class UIKit.UIApplication

public final class BrightSide {

    // MARK: - Public static methods

    /// Method return false, if we can detect some common for jailbroken deivce files or can write to device
    public static func isBright() -> Bool {
        // Check 1 : check if current device is simulator
        if isSimulator() {
            return true
        }

        // Check 2 : existence of files that are common for jailbroken devices
        if isJailbreakDirectoriesExist() || canOpenCydia() {
            return false
        }

        // Check 3 : Reading and writing in system directories (sandbox violation)
        let stringToWrite = "Jailbreak Test"
        do {
            try stringToWrite.write(toFile: "/private/JailbreakTest.txt",
                                    atomically: true,
                                    encoding: String.Encoding.utf8)
            //Device is jailbroken
            return false
        } catch {
            return true
        }
    }

}

// MARK: - Private help methods

private extension BrightSide {

    /// Method will return true, if any of the files or dir, typical for the jailbreak, exists
    static func isJailbreakDirectoriesExist() -> Bool {
        let jailbreakRelativelyFilesAndPaths = suspiciousSystemFiles
            + suspiciousAppsDir
            + suspiciousSystemDir
        return jailbreakRelativelyFilesAndPaths
            .allSatisfy(FileManager.default.fileExists(atPath:))
    }

    /// Method will return true if we can open cydia package
    static func canOpenCydia() -> Bool {
        guard let cydiaURL = URL(string: "cydia://package/com.example.package") else {
            return false
        }
        return UIApplication.shared.canOpenURL(cydiaURL)
    }

    /// Method will return true if current device is simulator
    static func isSimulator() -> Bool {
        return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
    }

}

// MARK: - Suspicious dir

extension BrightSide {

    static var suspiciousAppsDir: [String] {
        return [
            "/Applications/Cydia.app",
            "/Applications/blackra1n.app",
            "/Applications/checkra1n.app",
            "/Applications/Zeon.app",
            "/Applications/FakeCarrier.app",
            "/Applications/Icy.app",
            "/Applications/IntelliScreen.app",
            "/Applications/MxTube.app",
            "/Applications/RockApp.app",
            "/Applications/SBSettings.app",
            "/Applications/WinterBoard.app"
        ]
    }

    static var suspiciousSystemDir: [String] {
        return [
            "/private/var/lib/apt",
            "/private/var/lib/apt/",
            "/private/var/lib/cydia",
            "/private/var/mobile/Library/SBSettings/Themes",
            "/private/var/stash",
            "/usr/bin/sshd",
            "/usr/libexec/sftp-server",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/bin/bash"
        ]
    }

    static var suspiciousSystemFiles: [String] {
        return [
            "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
            "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
            "/private/var/tmp/cydia.log",
            "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
            "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
            "/Library/MobileSubstrate/MobileSubstrate.dylib"
        ]
    }

}
