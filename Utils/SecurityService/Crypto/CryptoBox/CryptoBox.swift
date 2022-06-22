//
//  CryptoBox.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

/// Interface for entity which can encrypt data and decrypt it.
/// Also specfic implementation must saves ecnrypted data in some storage
///
/// This interface means that single instants of box can work only with one piece of data and only with one key
/// so ypu can't ecnrypr 2 different pieces of data, because each `encrypt` would rewrite previous.
public protocol CryptoBox {
    /// Make encrypting operation on data with some auth item
    ///
    /// - Parameters:
    ///     - data: Cryptotext
    ///     - auth: Key whics was used to encrypt `data`
    func encrypt(data: String, auth: String) throws

    /// Make decryption operation on previously saved encrypted data
    ///
    /// - Parameters:
    ///     - authL Key whics was used to encrypt saved data
    func decrypt(auth: String) throws -> String
}
