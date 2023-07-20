//
//  OverrideViewControllerTest.swift
//  Chapter6HardDependenciesTests
//
//  Created by Jastin on 20/7/23.
//

import XCTest
@testable import Chapter6HardDependencies

final class OverrideViewControllerTest: XCTestCase {

    func test_ViewDidAppear() {
        let sut = OverrideViewController()
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }
}

extension OverrideViewControllerTest {
    private class TestableOverrideViewController: OverrideViewController {
        override func analytics() -> Analytics {
            Analytics()
        }
    }
}
