//
//  ClosePropertyViewControllerTest.swift
//  Chapter6HardDependenciesTests
//
//  Created by Jastin on 20/7/23.
//

import XCTest
@testable import Chapter6HardDependencies

final class ClosePropertyViewControllerTest: XCTestCase {
    
    func test_ViewDidLoad() {
        let sut = ClosureProperyViewController()
        sut.analytis = { Analytics() }
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }
}
