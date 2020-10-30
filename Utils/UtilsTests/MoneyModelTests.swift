//
//  MoneyModelTests.swift
//  UtilsTests
//

import Foundation
import XCTest

@testable import Utils

final class MoneyModelTests: XCTestCase {

    func testSumTwoZero() {
        // Arrange

        let left = MoneyModel(decimal: 0, digit: 0)
        let right = MoneyModel(decimal: 0, digit: 0)

        // Act

        let result = left.add(right)

        // Assert

        XCTAssertEqual(result.decimal, 0)
        XCTAssertEqual(result.digit, 0)
    }

    func testSumZeroAnd01() {
        // Arrange

        let left = MoneyModel(decimal: 0, digit: 0)
        let right = MoneyModel(decimal: 0, digit: 1)

        // Act

        let result = left.add(right)

        // Assert

        XCTAssertEqual(result.decimal, 0)
        XCTAssertEqual(result.digit, 1)
    }

    func testSumZeroAnd099() {
        // Arrange

        let left = MoneyModel(decimal: 0, digit: 0)
        let right = MoneyModel(decimal: 0, digit: 99)

        // Act

        let result = left.add(right)

        // Assert

        XCTAssertEqual(result.decimal, 0)
        XCTAssertEqual(result.digit, 99)
    }

    func testSum049And050() {
        // Arrange

        let left = MoneyModel(decimal: 0, digit: 49)
        let right = MoneyModel(decimal: 0, digit: 50)

        // Act

        let result = left.add(right)

        // Assert

        XCTAssertEqual(result.decimal, 0)
        XCTAssertEqual(result.digit, 99)
    }

    func testSum049And051() {
        // Arrange

        let left = MoneyModel(decimal: 0, digit: 49)
        let right = MoneyModel(decimal: 0, digit: 51)

        // Act

        let result = left.add(right)

        // Assert

        XCTAssertEqual(result.decimal, 1)
        XCTAssertEqual(result.digit, 0)
    }

    func testSum149And050() {
        // Arrange

        let left = MoneyModel(decimal: 1, digit: 49)
        let right = MoneyModel(decimal: 0, digit: 50)

        // Act

        let result = left.add(right)

        // Assert

        XCTAssertEqual(result.decimal, 1)
        XCTAssertEqual(result.digit, 99)
    }

    func testSum1049And1050() {
        // Arrange

        let left = MoneyModel(decimal: 10, digit: 49)
        let right = MoneyModel(decimal: 10, digit: 50)

        // Act

        let result = left.add(right)

        // Assert

        XCTAssertEqual(result.decimal, 20)
        XCTAssertEqual(result.digit, 99)
    }

    func testSum1099And1099() {
        // Arrange

        let left = MoneyModel(decimal: 10, digit: 99)
        let right = MoneyModel(decimal: 10, digit: 99)

        // Act

        let result = left.add(right)

        // Assert

        XCTAssertEqual(result.decimal, 21)
        XCTAssertEqual(result.digit, 98)
    }

    /// Если в строке будет записано к примеру `10` то будет создано число `decial: 10 digit: 0`
    func test10Returns10d0() {
        // Arrange

        let val = "10"

        // Act

        let res = MoneyModel(value: val)

        // Assert

        XCTAssertEqual(res?.decimal, 10)
        XCTAssertEqual(res?.digit, 0)
    }

    /// Если в строке будет записано к примеру `10.00` то будет как в предыдущем варианте
    func test1000Returns10d0() {
        // Arrange

        let val = "10.00"

        // Act

        let res = MoneyModel(value: val)

        // Assert

        XCTAssertEqual(res?.decimal, 10)
        XCTAssertEqual(res?.digit, 0)
    }

    /// Если в строке будет записано к примеру `10.01` то будет создано число `decimal: 10 digit: 1`
    func test1001Returns10d1() {
        // Arrange

        let val = "10.01"

        // Act

        let res = MoneyModel(value: val)

        // Assert

        XCTAssertEqual(res?.decimal, 10)
        XCTAssertEqual(res?.digit, 1)
    }

    /// Если в строке будет записано к примеру `10.100` то вернется `nil`
    func test10100ReturnsNil() {
        // Arrange

        let val = "10.100"

        // Act

        let res = MoneyModel(value: val)

        // Assert

        XCTAssertNil(res)
    }

    /// Если в строке будет записано `10.00.00` то вернется `nil`
    func test101000ReturnsNil() {
        // Arrange

        let val = "10.10.10"

        // Act

        let res = MoneyModel(value: val)

        // Assert

        XCTAssertNil(res)
    }

    /// Если в строке будет записано не число, то вернется `nil`
    func testNotNumberReturnsNil() {
        // Arrange

        let val = "sdfsdf"

        // Act

        let res = MoneyModel(value: val)

        // Assert

        XCTAssertNil(res)
    }
}
