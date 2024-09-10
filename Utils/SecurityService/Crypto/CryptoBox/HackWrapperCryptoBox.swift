//
//  HackWrapperCryptoBox.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

/// Hack-box wrapper
/// It is used to replace the cryptobox on the fly.
public struct HackWrapperCryptoBox: CryptoBox {

    private let box: PinHackCryptoBox

    public init(box: PinHackCryptoBox) {
        self.box = box
    }

    public func encrypt(data: String, auth: String) throws {
        try self.box.encrypt(data: data)
    }

    public func decrypt(auth: String) throws -> String {
        try self.box.decrypt()
    }

}
