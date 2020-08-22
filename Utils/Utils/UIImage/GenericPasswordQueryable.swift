//
//  GenericPasswordQueryable.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

// MARK: - SecureStoreQueryable

/// Keychain request interface
public protocol SecureStoreQueryable {
    var query: [String: Any] { get }
}

// MARK: - GenericPasswordQueryable

public struct GenericPasswordQueryable {

    let service: String
    let accessGroup: String?

    init(service: String, accessGroup: String? = nil) {
        self.service = service
        self.accessGroup = accessGroup
    }
}

// MARK: - GenericPasswordQueryable.SecureStoreQueryable

extension GenericPasswordQueryable: SecureStoreQueryable {
    public var query: [String: Any] {
        var query: [String: Any] = [
            kSecClass.plain: kSecClassGenericPassword,
            kSecAttrService.plain: service
        ]

        #if !targetEnvironment(simulator)
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup.plain] = accessGroup
        }
        #endif
        return query
    }
}

// MARK: - Support

extension CFString {
    var plain: String {
        return String(self)
    }
}
