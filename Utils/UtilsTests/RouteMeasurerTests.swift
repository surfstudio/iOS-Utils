//
//  RouteMeasurerTests.swift
//  UtilsTests
//
//  Created by Александр Чаусов on 05/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import XCTest
@testable import Utils

final class RouteMeasurerTests: XCTestCase {

    // MARK: - Constants

    private let meterPattern = "м"
    private let kilometrPattern = "км"
    
    // MARK: - Tests

    func testNegativeDistanceFormat() {
        let result = RouteMeasurer.formatDistance(-5, meterPattern: meterPattern, kilometrPatter: kilometrPattern)
        XCTAssertEqual(result, "0 " + meterPattern)
    }

    func testZeroDistanceFormat() {
        let result = RouteMeasurer.formatDistance(0, meterPattern: meterPattern, kilometrPatter: kilometrPattern)
        XCTAssertEqual(result, "0 " + meterPattern)
    }

    func testSmallDistanceFormat() {
        let result = RouteMeasurer.formatDistance(123, meterPattern: meterPattern, kilometrPatter: kilometrPattern)
        XCTAssertEqual(result, "123 " + meterPattern)
    }

    func testBigDistanceFormat() {
        let result = RouteMeasurer.formatDistance(12310, meterPattern: meterPattern, kilometrPatter: kilometrPattern)
        XCTAssertEqual(result, "12.3 " + kilometrPattern)
    }

    func testHugeDistanceFormat() {
        let result = RouteMeasurer.formatDistance(104123, meterPattern: meterPattern, kilometrPatter: kilometrPattern)
        XCTAssertEqual(result, "104 " + kilometrPattern)
    }

}
