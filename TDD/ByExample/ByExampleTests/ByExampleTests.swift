//
//  ByExampleTests.swift
//  ByExampleTests
//
//  Created by Jastin on 1/7/23.
//

import XCTest
@testable import ByExample

final class ByExampleTests: XCTestCase {

    func test_MaxTwoNumberShould_returnXIfIsGreater() {
        XCTAssertEqual(Workaround.max(2, y: 1), 2)
    }
    
    func test_MaxTwoNumberShould_returnYIfIsGreaterOrEqual() {
        XCTAssertEqual(Workaround.max(2, y: 2), 2)
    }
}
