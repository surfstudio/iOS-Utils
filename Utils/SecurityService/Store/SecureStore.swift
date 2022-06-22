//
//  SecureStore.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

/// Abstracts the entire protected store.
///
/// - SeeAlso: SecureDataProvider
public protocol SecureStore: SecureDataProvider {
    func remove(by key: String) throws
    /// Clears all storage from application data
    func removeAll() throws
}

/// Can save and read data to / from secure storage
public protocol SecureDataProvider {
    func save(data: String, by key: String) throws
    func load(by key: String) throws -> String
}
