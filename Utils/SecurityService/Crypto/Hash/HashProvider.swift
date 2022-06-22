//
//  HashProvider.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public protocol HashProvider {
    func hash(data: [UInt8]) throws -> [UInt8]
}
