//
//  WordDeclinationSelectorTests.swift
//  UtilsTests
//
//  Created by Александр Чаусов on 05/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import XCTest
@testable import Utils

final class WordDeclinationSelectorTests: XCTestCase {

    let form1 = "книга"
    let form2 = "книги"
    let form3 = "книг"

    func testDeclinationFor11_19() {
        testWordDeclinationSelector(sequence: [11, 12, 13, 14, 15, 16, 17, 18, 19, 115, 1018, 10912], correctForm: form3)
    }

    func testDeclinationForEndsIn1() {
        testWordDeclinationSelector(sequence: [1, 31, 141, 1941, 1081], correctForm: form1)
    }

    func testDeclinationForEndsIn2_4() {
        testWordDeclinationSelector(sequence: [2, 23, 54, 142, 5683, 49654], correctForm: form2)
    }

    func testDeclinationForEndsIn5_0() {
        testWordDeclinationSelector(sequence: [0, 5, 6, 7, 8, 9, 20, 50, 75, 106, 4267, 1088, 55439, 100000], correctForm: form3)
    }

}

private extension WordDeclinationSelectorTests {

    func testWordDeclinationSelector<S: Sequence>(sequence: S, correctForm: String) {
        for number in sequence.compactMap({ $0 as? Int }) {
            let result = WordDeclinationSelector.declineWord(for: number, from: WordDeclinations(form1, form2, form3))
            XCTAssertEqual(result, correctForm)
        }
    }

}
