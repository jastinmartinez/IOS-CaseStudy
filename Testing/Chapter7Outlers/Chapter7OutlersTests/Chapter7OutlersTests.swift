//
//  Chapter7OutlersTests.swift
//  Chapter7OutlersTests
//
//  Created by Jastin on 23/7/23.
//

import XCTest
@testable import Chapter7Outlers

final class Chapter7OutlersTests: XCTestCase {
    
    func test_outlets_ShouldBeConnected() {
        let sut = OutletViewController()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.label1, "label1")
        XCTAssertNotNil(sut.label2, "label2")
        XCTAssertNotNil(sut.stack1, "stack1")
    }
}
