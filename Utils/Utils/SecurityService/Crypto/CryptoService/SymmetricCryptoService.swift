//
//  SymmetricCryptoService.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public protocol SymmetricCryptoService {
    func encrypt(data: [UInt8], key: String, iv: String) throws -> [UInt8]
    func decrypt(data: [UInt8], key: String, iv: String) throws -> [UInt8]
}
