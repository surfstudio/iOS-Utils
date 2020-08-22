//
//  InMemorySecureStore.swift
//  Utils
//
//  Created by Никита Гагаринов on 20.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public class InMemorySecureStore: SecureStore {

    public var memory = [String: String]()

    public func remove(by key: String) throws {
        _ = self.memory.removeValue(forKey: key)
    }

    public func removeAll() throws {
        self.memory = [String: String]()
    }

    public func save(data: String, by key: String) throws {
        self.memory[key] = data
    }

    public func load(by key: String) throws -> String {
        guard let res = self.memory[key] else {
            throw NSError(domain: "err.mem", code: -1, userInfo: nil)
        }
        return res
    }

}
