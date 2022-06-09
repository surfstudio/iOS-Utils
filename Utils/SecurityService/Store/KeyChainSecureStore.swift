//
//  KeyChainSecureStore.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public struct KeyChainSecureStore: SecureStore {

    private let secureStoreQueryable: SecureStoreQueryable

    public init(secureStoreQueryable: SecureStoreQueryable) {
        self.secureStoreQueryable = secureStoreQueryable
    }

}

// MARK: - SecureDataProvider

extension KeyChainSecureStore {

    /// Adds data to the keychain.
    /// If nothing has been recorded for this `key` before, a new record is created.
    /// If there was already a record, the value is updated.
    ///
    /// - Throws:
    ///   - SecureStoreError
    ///
    /// - Parameters:
    ///   - data: Data for recording.
    ///   - key: The key by which the data will be recorded.
    public func save(data: String, by key: String) throws {
        guard let bin = data.data(using: .utf8) else {
            throw SecureStoreError.stringToDataConversionError
        }

        var query = secureStoreQueryable.query
        query[kSecAttrAccount.plain] = key

        // Looking for data for this key

        var status = SecItemCopyMatching(query as CFDictionary, nil)

        switch status {

        case errSecSuccess:

            // If found then just update

            var attributesToUpdate: [String: Any] = [:]
            attributesToUpdate[kSecValueData.plain] = bin

            status = SecItemUpdate(query as CFDictionary,
                                   attributesToUpdate as CFDictionary)
            if status != errSecSuccess {
                throw error(from: status)
            }

        case errSecItemNotFound:

            // Not found - adding

            query[kSecValueData.plain] = bin

            status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                throw error(from: status)
            }
        default:
            throw error(from: status)
        }
    }

    /// Reads data for a specific key.
    /// If nothing was written for the key, it will throw an error.
    ///
    /// - Throws:
    ///   - SecureStoreError
    ///
    /// - Parameter key: The key by which the data is searched.
    public func load(by key: String) throws -> String {
        var query = secureStoreQueryable.query
        query[kSecMatchLimit.plain] = kSecMatchLimitOne
        query[kSecReturnAttributes.plain] = kCFBooleanTrue
        query[kSecReturnData.plain] = kCFBooleanTrue
        query[kSecAttrAccount.plain] = key

        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, $0)
        }

        switch status {
        case errSecSuccess:
            guard
                let queriedItem = queryResult as? [String: Any],
                let data = queriedItem[kSecValueData.plain] as? Data,
                let strData = String(data: data, encoding: .utf8)
            else {
                throw SecureStoreError.dataToStringConversionError
            }
            return strData
        case errSecItemNotFound:
            throw error(from: status)
        default:
            throw error(from: status)
        }
    }

}

// MARK: - Removals

extension KeyChainSecureStore {

    public func remove(by key: String) throws {
        var query = secureStoreQueryable.query
        query[kSecAttrAccount.plain] = key

        let status = SecItemDelete(query as CFDictionary)

        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw error(from: status)
        }
    }

    public func removeAll() throws {
        let query = secureStoreQueryable.query

        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw error(from: status)
        }
    }

}

private extension KeyChainSecureStore {
    private func error(from status: OSStatus) -> SecureStoreError {
          var message = ""

          if #available(iOS 11.3, *) {
              message = SecCopyErrorMessageString(status, nil) as String? ?? "Some undefind error"
          } else {
              message = status.description
          }
          return SecureStoreError.unhandledError(message: message)
      }
}
