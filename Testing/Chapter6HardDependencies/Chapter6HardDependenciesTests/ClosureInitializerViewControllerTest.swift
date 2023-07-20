//
//  ClosureInitializerViewControllerTest.swift
//  Chapter6HardDependenciesTests
//
//  Created by Jastin on 20/7/23.
//

import XCTest
@testable import Chapter6HardDependencies

final class ClosureInitializerViewControllerTest: XCTestCase {

    func test_ViewDidLoad() {
        let sut = ClosureInitializerViewController(makeAnalytics: { return Analytics() })
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }
}
