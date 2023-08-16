//
//  ItemsScrollManagerTests.swift
//  UtilsTests
//
//  Created by Дмитрий Демьянов on 15.08.2023.
//  Copyright © 2023 Surf. All rights reserved.
//

import XCTest
@testable import Utils

class ItemsScrollManagerTests: XCTestCase {

    // MARK: -  Constants

    private let cellWidth: CGFloat = 200
    private let cellSpacing: CGFloat = 20
    private let edgeInset: CGFloat = 10
    private var pageWidth: CGFloat { cellWidth + cellSpacing }

    // MARK: - Private Properties

    private let scrollView = UIScrollView()

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        scrollView.contentSize = CGSize(width: pageWidth * 10, height: 200)
    }

}

// MARK: - Left Alignment Tests

extension ItemsScrollManagerTests {

    func testLeftAlignmentProgressAtFirstCellStart() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .left)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 0)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 0)
    }

    func testLeftAlignmentProgressAtFirstCellMiddle() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .left)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 0.5)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 0.5)
    }

    func testLeftAlignmentProgressAtFirstCellEnd() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .left)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 1)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 1)
    }

    func testLeftAlignmentProgressAtMiddleCellStart() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .left)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 5)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 5)
    }

    func testLeftAlignmentProgressAtMiddleCellMiddle() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .left)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 5.5)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 5.5)
    }

    func testLeftAlignmentProgressAtMiddleCellEnd() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .left)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 6)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 6)
    }

    func testLeftAlignmentProgressAtLastCellStart() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .left)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 8)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 8)
    }

    func testLeftAlignmentProgressAtLastCellMiddle() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .left)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 8.5)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 9)
    }

    func testLeftAlignmentProgressAtLastCellEnd() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .left)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 9)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 9)
    }

}

// MARK: - Center Alignment Tests

extension ItemsScrollManagerTests {

    func testCenterAlignmentProgressAtFirstCellStart() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .centered)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 0)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 0)
    }

    func testCenterAlignmentProgressAtFirstCellMiddle() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .centered)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 0.5)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 0.77)
    }

    func testCenterAlignmentProgressAtFirstCellEnd() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .centered)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 1)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 1.35)
    }

    func testCenterAlignmentProgressAtMiddleCellStart() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .centered)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 5)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 5.35)
    }

    func testCenterAlignmentProgressAtMiddleCellMiddle() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .centered)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 5.5)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 5.85)
    }

    func testCenterAlignmentProgressAtMiddleCellEnd() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .centered)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 6)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 6.35)
    }

    func testCenterAlignmentProgressAtLastCellStart() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .centered)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 8)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 8.54)
    }

    func testCenterAlignmentProgressAtLastCellMiddle() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .centered)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 8.5)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 9)
    }

    func testCenterAlignmentProgressAtLastCellEnd() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .centered)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 9)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 9)
    }

}

// MARK: - Right Alignment Tests

extension ItemsScrollManagerTests {

    func testRightAlignmentProgressAtFirstCellStart() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .right)

        // Act

        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 0)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 0)
    }

    func testRightAlignmentProgressAtFirstCellMiddle() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .right)

        // Act

        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 0.5)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 1.2)
    }

    func testRightAlignmentProgressAtFirstCellEnd() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .right)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 1)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 1.7)
    }

    func testRightAlignmentProgressAtMiddleCellStart() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .right)

        // Act

        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 5)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 5.7)
    }

    func testRightAlignmentProgressAtMiddleCellMiddle() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .right)

        // Act

        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 5.5)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 6.2)
    }

    func testRightAlignmentProgressAtMiddleCellEnd() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .right)

        // Act

        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 6)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 6.7)
    }

    func testRightAlignmentProgressAtLastCellStart() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .right)

        // Act

        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 8)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 8.7)
    }

    func testRightAlignmentProgressAtLastCellMiddle() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .right)

        // Act
        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 8.5)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 9)
    }

    func testRightAlignmentProgressAtLastCellEnd() {
        // Arrange
        let scrollManager = makeScrollManager(alignment: .right)

        // Act

        let pageProgress = scrollManager.getPageProgress(for: scrollView, targetOffset: pageWidth * 9)

        // Assert
        XCTAssertNearlyEqual(pageProgress, 9)
    }

}

// MARK: - Private Methods

private extension ItemsScrollManagerTests {

    func makeScrollManager(alignment: ItemsScrollManager.CellAlignment) -> ItemsScrollManager {
        return ItemsScrollManager(
            cellWidth: cellWidth,
            cellOffset: cellSpacing,
            insets: UIEdgeInsets(top: 0, left: edgeInset, bottom: 0, right: edgeInset),
            containerWidth: 375, // iPhone 8 width
            alignment: alignment
        )
    }

}

// MARK: - XCTAssert

private func XCTAssertNearlyEqual(
    _ expression1: CGFloat,
    _ expression2: CGFloat,
    _ message: String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTAssertLessThanOrEqual(abs(expression1 - expression2), 0.01, message, file: file, line: line)
}
