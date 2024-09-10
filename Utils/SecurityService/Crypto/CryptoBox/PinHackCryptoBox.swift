//
//  PinHackCryptoBox.swift
//  Utils
//
//  Created by Никита Гагаринов on 21.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

/// Crypto-box used for refreshing security data
public struct PinHackCryptoBox {

    private let secureStore: () -> SecureStore
    private let cryptoService: SymmetricCryptoService

    private let ivKey: String
    private let dataKey: String
    private let saltKey: String
    private let hashKey: String

    public init(secureStore: @escaping () -> SecureStore,
         cryptoService: SymmetricCryptoService,
         ivKey: String,
         dataKey: String,
         saltKey: String,
         hashKey: String) {

        self.secureStore = secureStore
        self.cryptoService = cryptoService

        self.ivKey = ivKey
        self.dataKey = dataKey
        self.saltKey = saltKey
        self.hashKey = hashKey
    }

    public func encrypt(data: String) throws {
        let hash: String = try self.secureStore().load(by: self.hashKey)
        let iv: String = try self.secureStore().load(by: self.ivKey)

        guard let bytes = data.data(using: .utf8, allowLossyConversion: false) else {
            throw CryptoBoxCommonError.cantConvertStringToData
        }

        let plain = try self.cryptoService.encrypt(data: bytes.bytes, key: hash, iv: iv)

        try self.secureStore().save(data: Data(plain).base64EncodedString(), by: self.dataKey)
    }

    public func decrypt() throws -> String {
        let data: String = try self.secureStore().load(by: self.dataKey)
        let hash: String = try self.secureStore().load(by: self.hashKey)
        let iv: String = try self.secureStore().load(by: self.ivKey)

        guard let decoded = Data(base64Encoded: data) else {
            throw CryptoBoxCommonError.cantConvertStringToData
        }

        let plain = try self.cryptoService.decrypt(data: decoded.bytes, key: hash, iv: iv)

        guard let str = String(data: Data(plain), encoding: .utf8) else {
            throw CryptoBoxCommonError.cantConvertDataToString
        }

        return str
    }

}

public extension PinHackCryptoBox {
    func erase() -> CryptoBox {
        return HackWrapperCryptoBox(box: self)
    }
}
