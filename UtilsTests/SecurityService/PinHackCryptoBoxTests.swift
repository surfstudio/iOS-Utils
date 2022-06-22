//
//  PinHackCryptoBoxTests.swift
//  UtilsTests
//
//  Created by Никита Гагаринов on 03.11.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import XCTest
import CryptoSwift
import Foundation

@testable import Utils

final class PinHackCryptoBoxTests: XCTestCase {

    private let cryptoBox = PinCryptoBox(secureStore: { KeyChainSecureStore(
                                            secureStoreQueryable: GenericPasswordQueryable(service: "")) },
                                         hashProvider: SHA3(variant: .sha224),
                                         cryptoService: BlowfishCryptoService(),
                                         ivKey: "ivKey",
                                         dataKey: "dataKey",
                                         saltKey: "saltKey",
                                         hashKey: "hashKey")
    private let hackBox = PinCryptoBox(secureStore: { KeyChainSecureStore(
                                        secureStoreQueryable: GenericPasswordQueryable(service: "")) },
                                     hashProvider: SHA3(variant: .sha224),
                                     cryptoService: BlowfishCryptoService(),
                                     ivKey: "ivKey",
                                     dataKey: "dataKey",
                                     saltKey: "saltKey",
                                     hashKey: "hashKey").hack()

    private let data = "123"
    private let newData = "asd"
    private let key = "123"

    override func setUp() {
        super.setUp()
        try? self.cryptoBox.encrypt(data: self.data, auth: self.key)
    }

    func testCryptoBoxCanDecryptWithouErrors() {
        XCTAssertNoThrow(try hackBox.decrypt())
    }

    func testCryptoBoxCanDecryptRight() {
        XCTAssertEqual(self.data, try? self.hackBox.decrypt())
    }

    func testCryptoBoxCanEncryptRight() {
        try? hackBox.encrypt(data: self.newData)
        XCTAssertEqual(self.newData, try? self.cryptoBox.decrypt(auth: self.key))
    }
}
