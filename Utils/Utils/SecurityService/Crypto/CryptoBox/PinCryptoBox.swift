//
//  PinCryptoBox.swift
//  Utils
//
//  Created by Никита Гагаринов on 21.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

/// Common used implementation of "Cryptography by PIN"
///
/// This box incapsulate all crypto-things and provide simple interface that looks like you really encrypt your data i=only by PIN
/// But ander-the-hood it uses symmetric scrypto algorythm
/// You just need to provide data for this alg. and box will do encryption, decription and storing by itself.
public struct PinCryptoBox: CryptoBox {

    private let secureStore: () -> SecureStore
    private let hashProvider: HashProvider
    private let cryptoService: SymmetricCryptoService

    private let ivKey: String
    private let dataKey: String
    private let saltKey: String
    private let hashKey: String

    /// Initializer
    /// - Parameters:
    ///   - secureStore: Entity which stores cryptotext and other data that needs for decrypt operation
    ///   - hashProvider: Entity which provides hash alg.
    ///   - cryptoService: Entity which provider crypto alg.
    ///   - ivKey: This is the name of the field which will be usining in storage (as name) for initialization vector
    ///   - dataKey: This is the name of the field which will be usining in storage (as name) for cryptotext
    ///   - saltKey: This is the name of the field which will be usining in storage (as name) for salt
    ///   - hashKey: This is the name of the field which will be usining in storage (as name) for hash
    public init(secureStore: @escaping () -> SecureStore,
         hashProvider: HashProvider,
         cryptoService: SymmetricCryptoService,
         ivKey: String,
         dataKey: String,
         saltKey: String,
         hashKey: String) {

        self.secureStore = secureStore
        self.hashProvider = hashProvider
        self.cryptoService = cryptoService

        self.ivKey = ivKey
        self.dataKey = dataKey
        self.saltKey = saltKey
        self.hashKey = hashKey
    }

    public func encrypt(data: String, auth: String) throws {

        let salt = CryptoCommon.random(count: 32).toHexString()
        let iv = CryptoCommon.random(count: 4).toHexString()

        try self.secureStore().save(data: salt, by: self.saltKey)
        try self.secureStore().save(data: iv, by: self.ivKey)

        let key = self.add(salt: salt, to: auth)
        let hash = try self.hashProvider
            .hash(data: key.bytes)
            .toHexString()

        try self.secureStore().save(data: hash, by: self.hashKey)

        guard let binaryData = data.data(using: .utf8, allowLossyConversion: false) else {
            throw CryptoBoxCommonError.cantConvertStringToData
        }

        let result = try self.cryptoService.encrypt(data: binaryData.bytes, key: hash, iv: iv)

        try self.secureStore().save(data: Data(result).base64EncodedString(), by: dataKey)
    }

    public func decrypt(auth: String) throws -> String {

        let data: String = try self.secureStore().load(by: self.dataKey)
        let salt: String = try self.secureStore().load(by: self.saltKey)
        let iv: String = try self.secureStore().load(by: self.ivKey)

        let key = self.add(salt: salt, to: auth)
        let hash = try self.hashProvider
            .hash(data: key.bytes)
            .toHexString()

        guard let decoded = Data(base64Encoded: data) else {
            throw CryptoBoxCommonError.cantConvertStringToData
        }

        let plain = try self.cryptoService.decrypt(data: decoded.bytes, key: hash, iv: iv)

        guard let result = String(data: Data(plain), encoding: .utf8) else {
            throw CryptoBoxCommonError.cantConvertDataToString
        }

        return result
    }

}

private extension PinCryptoBox {

    func add(salt: String, to data: String) -> String {

        var result = data

        for (index, item) in salt.enumerated() {
            if index % 2 == 0 {
                result.append(item)
            } else {
                result.insert(item, at: data.startIndex)
            }
        }

        return result
    }

}

public extension PinCryptoBox {
    ///Hack-box initializer
    func hack() -> PinHackCryptoBox {
        return .init(secureStore: self.secureStore,
                     cryptoService: self.cryptoService,
                     ivKey: self.ivKey,
                     dataKey: self.dataKey,
                     saltKey: self.saltKey,
                     hashKey: self.hashKey)
    }
}
