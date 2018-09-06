//
//  JailbreakDetect.swift
//  Utils
//
//  Created by Vlad Krupenko on 05.09.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

import Foundation

final class JailbreakDetect {

    // MARK: - Internal static methods

    /// Method return true, if we can detect some common for jailbroken deivce files or can write to device
    static func isJailBroken() -> Bool {
        // Check 1 : existence of files that are common for jailbroken devices
        if isJailbreakDirectoriesExist() || canOpenCydia() {
            return true
        }

        // Check 2 : Reading and writing in system directories (sandbox violation)
        let stringToWrite = "Jailbreak Test"
        do {
            try stringToWrite.write(toFile: "/private/JailbreakTest.txt", atomically: true, encoding: String.Encoding.utf8)
            //Device is jailbroken
            return true
        } catch {
            return false
        }
    }

    // MARK: - Private help methods

    /// Method will return true, if any of the files typical for the jailbreak exists
    private static func isJailbreakDirectoriesExist() -> Bool {
        let jailbreakDirectories = ["/Applications/Cydia.app", "/Library/MobileSubstrate/MobileSubstrate.dylib", "/bin/bash", "/usr/sbin/sshd", "/etc/apt", "/private/var/lib/apt/"]
        return jailbreakDirectories.map { FileManager.default.fileExists(atPath: $0) }.reduce(true, { $0 || $1 })
    }

    /// Method will return true if we can open cydia package
    private static func canOpenCydia() -> Bool {
        guard let cydiaURL = URL(string: "cydia://package/com.example.package") else {
            return false
        }
        return UIApplication.shared.canOpenURL(cydiaURL)
    }

}
