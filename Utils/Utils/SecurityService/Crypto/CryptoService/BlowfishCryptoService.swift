//
//  BlowfishCryptoService.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation
import CryptoSwift

public final class BlowfishCryptoService: SymmetricCryptoService {

    public init() {}

    public func encrypt(data: [UInt8], key: String, iv: String) throws -> [UInt8] {
        let alg = try Blowfish(key: key, iv: iv, padding: .pkcs7)
        return try alg.encrypt(data)
    }

    public func decrypt(data: [UInt8], key: String, iv: String) throws -> [UInt8] {
        let alg = try Blowfish(key: key, iv: iv, padding: .pkcs7)
        return try alg.decrypt(data)
    }

}
