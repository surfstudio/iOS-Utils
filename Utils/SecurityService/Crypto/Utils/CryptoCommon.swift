//
//  CryptoCommon.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public enum CryptoCommon {
    public static func random(count: Int) -> [UInt8] {
        var bytes = [UInt8](repeating: 0, count: count)
        _ = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        return bytes
    }
}
