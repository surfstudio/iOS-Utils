//
//  LocalStorageTests.swift
//  UtilsTests
//
//  Created by Anton Dryakhlykh on 11.11.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import XCTest
@testable import Utils

struct User: Codable, Equatable {
    let id: Int
    let name: String
}

struct Time: Codable {
    let seconds: Double
}

final class LocalStorageTests: XCTestCase {

    // MARK: - Test methods

    func testStoring() {

        // given

        let user = User(id: 3, name: "Jesus")
        let filename = "testStoring"

        // when

        try? LocalStorage.store(object: user, as: filename)

        // then

        XCTAssertNotNil(try LocalStorage.load(fileName: filename, as: User.self))
    }

    func testLoading() {

        // given

        let user = User(id: 3, name: "Jesus")
        let filename = "testLoading"

        // when

        try? LocalStorage.store(object: user, as: filename)
        let loadedUser = try? LocalStorage.load(fileName: filename, as: User.self)

        // then

        XCTAssertEqual(loadedUser, user)
    }

    func testRemoving() {

        // given

        let user = User(id: 3, name: "Jesus")
        let filename = "testRemoving"
        var error: Error?

        // when

        try? LocalStorage.store(object: user, as: filename)
        try? LocalStorage.remove(fileName: filename)

        // then

        XCTAssertThrowsError(try LocalStorage.load(fileName: filename, as: User.self)) {
            error = $0
        }

        XCTAssertTrue(error is LocalStorage.Error.Load)
        XCTAssertEqual(error as? LocalStorage.Error.Load, .fileNotExist)
    }

    // MARK: - Test error catching

    func testStoringErrorCannotEncode() {

        // given

        let time = Time(seconds: .infinity)
        let filename = "testStoringErrorCannotEncode"
        var error: Error?

        // when

        XCTAssertThrowsError(try LocalStorage.store(object: time, as: filename)) {
            error = $0
        }

        // then

        XCTAssertTrue(error is LocalStorage.Error.Store)
        XCTAssertEqual(error as? LocalStorage.Error.Store, .cannotEncode)
    }

    func testLoadingErrorCannotDecode() {

        // given

        let user = User(id: 3, name: "Jesus")
        let filename = "testLoadingErrorCannotDecode"
        var error: Error?

        // when

        try? LocalStorage.store(object: user, as: filename)

        XCTAssertThrowsError(try LocalStorage.load(fileName: filename, as: Time.self)) {
            error = $0
        }

        // then

        XCTAssertTrue(error is LocalStorage.Error.Load)
        XCTAssertEqual(error as? LocalStorage.Error.Load, .cannotDecode)
    }
}
