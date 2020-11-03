//
//  KeyChainSecureStoreTests.swift
//  UtilsTests
//
//  Created by Никита Гагаринов on 03.11.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import XCTest

@testable import Utils

final class KeyChainSecureStoreTests: XCTestCase {

    var store = KeyChainSecureStore(secureStoreQueryable: GenericPasswordQueryable(service: ""))

    override func tearDown() {
        try? self.store.removeAll()
        super.tearDown()
    }

    func testSaveGenericPasswordNotThrow() {
        do {
            try self.store.save(data: "pwd_1234", by: "testSaveGenericPasswordNotThrow")
        } catch {
            XCTFail("\(error)")
        }
    }

    func testReadGenericPassword() {

        // Arrange

        let data = "123"
        let key = "testReadGenericPassword"

        // Act-Assert

        do {
            try self.store.save(data: data, by: key)
            let readed = try self.store.load(by: key)
            XCTAssertEqual(data, readed)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testUpdateGenericPassword() {

        // Arrange

        let data1 = "123"
        let data2 = "asd"
        let key = "testUpdateGenericPassword"

        // Act-Assert

        do {
            try self.store.save(data: data1, by: key)
            try self.store.save(data: data2, by: key)
            let password = try self.store.load(by: key)
            XCTAssertEqual(data2, password)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testRemoveGenericPassword() {

        // Arrange

        let data = "123"
        let key = "testRemoveGenericPassword"

        // Act-Assert

        do {
            try self.store.save(data: data, by: key)
            try self.store.remove(by: key)
            XCTAssertThrowsError(try self.store.load(by: key))
        } catch {
            XCTFail("\(error)")
        }
    }

    func testRemoveAllGenericPasswords() {

        // Arrange

        let data = "123"
        let key1 = "testRemoveAllGenericPasswords1"
        let key2 = "testRemoveAllGenericPasswords2"

        // Act-Assert

        do {
            try self.store.save(data: data, by: key1)
            try self.store.save(data: data, by: key2)
            try self.store.removeAll()
            XCTAssertThrowsError(try self.store.load(by: key1))
            XCTAssertThrowsError(try self.store.load(by: key2))
        } catch {
            XCTFail("\(error)")
        }
    }
}
