//
//  PinCryptoBoxTests.swift
//  UtilsTests
//
//  Created by Никита Гагаринов on 03.11.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import XCTest
import CryptoSwift
import Foundation

@testable import Utils

final class PinCryptoBoxTests: XCTestCase {

    private let cryptoBox = PinCryptoBox(secureStore: { KeyChainSecureStore(
                                            secureStoreQueryable: GenericPasswordQueryable(service: "")) },
                                         hashProvider: SHA3(variant: .sha224),
                                         cryptoService: BlowfishCryptoService(),
                                         ivKey: "ivKey",
                                         dataKey: "dataKey",
                                         saltKey: "saltKey",
                                         hashKey: "hashKey")

    func testCryptoBoxCanEncryptWithouErrors() {

        // Arrange

        let data = "123"
        let key = "123"

        // Act - Assert

        XCTAssertNoThrow(try cryptoBox.encrypt(data: data, auth: key))
    }

    func testCryptoBoxCanDecryptWithouErrors() {

        // Arrange

        let data = "123"
        let key = "123"

        // Act - Assert

        XCTAssertNoThrow(try cryptoBox.encrypt(data: data, auth: key))
        XCTAssertNoThrow(try cryptoBox.decrypt(auth: key))
    }

    func testCryptoBoxCanEnryptRight() {

        // Arrange

        let data = "123"
        let key = "123"

        // Act

        try? cryptoBox.encrypt(data: data, auth: key)

        // Assert

        XCTAssertEqual(data, try? cryptoBox.decrypt(auth: key))
    }

    func testCryptoBoxThrowsErrorForEmptyStore() {

        // Arrange

        let key = "123"

        // Act

        try? KeyChainSecureStore(secureStoreQueryable: GenericPasswordQueryable(service: "")).removeAll()

        // Assert

        XCTAssertThrowsError(try cryptoBox.decrypt(auth: key))
    }
}
