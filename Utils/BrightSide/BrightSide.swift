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

        // Check 2 : Suspicious URL Schemes:
        ///Warning: Schemes should be added in Info.plist LSApplicationQueriesSchemes in other case check will always return false
        if suspiciousURLs.contains(where: { canOpenUrl(urlString: $0) }) {
            return false
        }

        // Check 3 : existence of files that are common for jailbroken devices
        if isJailbreakDirectoriesExist() || isSuspiciousFilesCanBeOpened() {
            return false
        }

        // Check 4 : Reading and writing in system directories (sandbox violation)
        if canWriteToRestrictedPaths() {
            return false
        }

        return true

    }

}

// MARK: - Private help methods

private extension BrightSide {

    /// Method will return true, if any of the files or dir, typical for the jailbreak, exists
    static func isJailbreakDirectoriesExist() -> Bool {
        var jailbreakPaths = suspiciousSystemFiles + suspiciousAppsDir + suspiciousSystemDir

        // These files can give false positive in the simulator
        if !isSimulator() {
            jailbreakPaths += [
                "/bin/bash",
                "/usr/sbin/sshd",
                "/usr/libexec/ssh-keysign",
                "/bin/sh",
                "/etc/ssh/sshd_config",
                "/usr/libexec/sftp-server",
                "/usr/bin/ssh"
            ]
        }

        return jailbreakPaths.contains { FileManager.default.fileExists(atPath: $0) }
    }

    /// Method will return true, if any of the files or dir, typical for the jailbreak, openable
    static func isSuspiciousFilesCanBeOpened() -> Bool {
        var jailbreakPaths = [
            "/.installed_unc0ver",
            "/.bootstrapped_electra",
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/etc/apt",
            "/var/log/apt"
        ]

        // These files can give false positive in the emulator
        if !isSimulator() {
            jailbreakPaths += [
                "/bin/bash",
                "/usr/sbin/sshd",
                "/usr/bin/ssh"
            ]
        }

        return jailbreakPaths.contains { FileManager.default.isReadableFile(atPath: $0) }
    }

    /// Method will return true if we can open cydia package
    static func canOpenUrl(urlString: String) -> Bool {
        guard let URL = URL(string: urlString) else {
            return false
        }
        return UIApplication.shared.canOpenURL(URL)
    }

    /// Method will return true if current device is simulator
    static func isSimulator() -> Bool {
        return isSimulatorCompile() || isSimulatorRuntime()
    }

    /// Check if writing to restricted paths is possible
    static func canWriteToRestrictedPaths() -> Bool {
        let restrictedPaths = [
            "/",
            "/root/",
            "/private/",
            "/jb/"
        ]

        let stringToWrite = "Jailbreak Test"
        for path in restrictedPaths {
            let someRandomRestrictedPath = path + UUID().uuidString
            do {
                try stringToWrite.write(toFile: someRandomRestrictedPath,
                                        atomically: true,
                                        encoding: .utf8)
                // If writing succeeds, the device is jailbroken
                return true
            } catch {
                // Continue trying other paths
                continue
            }
        }
        // If no restricted paths could be written to, return false (not jailbroken)
        return false
    }

}

// MARK: - Suspicious directories and files

private extension BrightSide {

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
            "/Applications/WinterBoard.app",
            "/Applications/Activator.app",
            "/Applications/BytaFont.app",
            "/Applications/Filza.app",
            "/Applications/Sileo.app",
        ]
    }

    static var suspiciousSystemDir: [String] {
        return [
            "/private/var/lib/apt",
            "/private/var/lib/cydia",
            "/private/var/mobile/Library/SBSettings/Themes",
            "/private/var/stash",
            "/usr/bin/sshd",
            "/etc/apt",
            "/usr/libexec/cydia",
            "/private/var/jb",
            "/var/mobile/Library/Preferences/ABPattern", // A-Bypass
            "/usr/lib/ABDYLD.dylib", // A-Bypass,
            "/usr/lib/ABSubLoader.dylib", // A-Bypass
            "/usr/sbin/frida-server", // frida
            "/etc/apt/sources.list.d/electra.list", // electra
            "/etc/apt/sources.list.d/sileo.sources", // electra
            "/.bootstrapped_electra", // electra
            "/usr/lib/libjailbreak.dylib", // electra
            "/jb/lzma", // electra
            "/.cydia_no_stash", // unc0ver
            "/.installed_unc0ver", // unc0ver
            "/jb/offsets.plist", // unc0ver
            "/usr/share/jailbreak/injectme.plist", // unc0ver
            "/etc/apt/undecimus/undecimus.list", // unc0ver
            "/var/lib/dpkg/info/mobilesubstrate.md5sums", // unc0ver
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/jb/jailbreakd.plist", // unc0ver
            "/jb/amfid_payload.dylib", // unc0ver
            "/jb/libjailbreak.dylib", // unc0ver
        ]
    }

    static var suspiciousSystemFiles: [String] {
        return [
            "/Library/MobileSubstrate/DynamicLibraries/SSLKillSwitch2.plist",
            "/Library/MobileSubstrate/DynamicLibraries",
            "/usr/sbin/frida-server", // frida
            "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
            "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
            "/private/var/tmp/cydia.log",
            "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
            "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/private/var/db/crashreporter/LiveClock.plist",
            "/usr/lib/libsubstitute.dylib",
            "/private/var/lib/apt/periodic"
        ]
    }

    static var suspiciousURLs: [String] {
        return [
            "cydia://package/com.example.package",
            "filza://",
            "undecimus://",
            "zbra://",
            "sileo://"
        ]
    }

}

// MARK: - Private Methods

private extension BrightSide {

    static func isSimulatorRuntime() -> Bool {
        return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
    }

    static func isSimulatorCompile() -> Bool {
#if targetEnvironment(simulator)
        return true
#else
        return false
#endif
    }

}
