//
//  SecureStoreError.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public enum SecureStoreError: Error {
    case stringToDataConversionError
    case dataToStringConversionError
    case unhandledError(message: String)
}
