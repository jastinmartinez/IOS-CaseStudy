//
//  InstanceInitializersViewControllerTest.swift
//  Chapter6HardDependenciesTests
//
//  Created by Jastin on 20/7/23.
//

import XCTest
@testable import Chapter6HardDependencies

final class InstanceInitializersViewControllerTest: XCTestCase {
    func test_ViewDidLoadWithDefaulParameter() {
        let sut = InstanceInitializersViewController()
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
        XCTAssertTrue(sut.isViewLoaded)
    }
    
    func test_ViewDidLoadWithInputParameter() {
        let sut = InstanceInitializersViewController(analytics: Analytics())
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
        XCTAssertTrue(sut.isViewLoaded)
    }
}
