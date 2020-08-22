//
//  CryptoBox.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public protocol CryptoBox {
    func encrypt(data: String, auth: String) throws
    func decrypt(auth: String) throws -> String
}
