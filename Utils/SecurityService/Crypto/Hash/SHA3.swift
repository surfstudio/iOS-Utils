//
//  SHA3.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation
import CryptoSwift

extension SHA3: HashProvider {
    public func hash(data: [UInt8]) throws -> [UInt8] {
        self.calculate(for: data)
    }
}
