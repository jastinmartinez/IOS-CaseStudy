//
//  FoundationChapterThreeTest.swift
//  TDDTests
//
//  Created by Jastin on 15/7/23.
//

import XCTest
@testable import TDD

final class FoundationChapterThreeTest: XCTestCase {

    /// Loop Converage
    func test_commaSeparated_from2to4_shouldReturnSomething() {
        let result = FoundationChapterThree.commaSeparated(from: 2, to: 4)
        XCTAssertEqual(result, "2,3,4")
    }
    /// Loop Converage
    func test_commaSeparated_from2To2_shouldReturnWithNoComma() {
        let result = FoundationChapterThree.commaSeparated(from: 2, to: 2)
        XCTAssertEqual(result, "2")
    }
    
    func test_area_withWidth7_shouldBe49() {
        let sut = FoundationChapterThree()
        sut.width = 7
        XCTAssertEqual(sut.area, 49)
    }
    
    func test_nunmberToString_inputNumber2_Return2AsString() {
        XCTAssertEqual(FoundationChapterThree.numberToString(2), "2")
    }
    
    func test_nunmberToString_inputNumberNegative2_ReturnNegative2AsString() {
        XCTAssertEqual(FoundationChapterThree.numberToString(-2), "-2")
    }
    
    func test_nunmberToString_inputNumberZero_ReturnEmpty() {
        XCTAssertEqual(FoundationChapterThree.numberToString(0), "")
    }
    
    func test_numberToString_InputMultipleNumbers_ReturnMultiplesNumberSeparatedByComma() {
        XCTAssertEqual(FoundationChapterThree.numberToString(12), "1,2")
    }
    
    func test_numberToString_InputMultipleNegativeNumbers_ReturnMultiplesNegativeNumberSeparatedByComma() {
        XCTAssertEqual(FoundationChapterThree.numberToString(-12), "-1,-2")
    }
}
