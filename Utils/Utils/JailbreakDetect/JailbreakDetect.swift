//
//  JailbreakDetect.swift
//  Utils
//
//  Created by Vlad Krupenko on 05.09.2018.
//  Copyright © 2018 Surf. All rights reserved.
//

import Foundation

final class JailbreakDetect {

    /// Method return true, if we can detect some common for jailbroken deivce files or can write to device
    static func isJailBroken() -> Bool {
        // Check 1 : existence of files that are common for jailbroken devices
        if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
            || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
            || FileManager.default.fileExists(atPath: "/bin/bash")
            || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
            || FileManager.default.fileExists(atPath: "/etc/apt")
            || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
            || canOpenCydia() {
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

    /// Method will return true if we can open cydia package
    private static func canOpenCydia() -> Bool {
        guard let cydiaURL = URL(string: "cydia://package/com.example.package") else {
            return false
        }
        return UIApplication.shared.canOpenURL(cydiaURL)
    }

}
