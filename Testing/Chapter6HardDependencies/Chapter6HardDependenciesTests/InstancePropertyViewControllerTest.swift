//
//  InstancePropertyViewControllerTest.swift
//  Chapter6HardDependenciesTests
//
//  Created by Jastin on 20/7/23.
//

import XCTest
@testable import Chapter6HardDependencies

final class InstancePropertyViewControllerTest: XCTestCase {

    func test_viewDidload() {
        let sut = InstancePropertyViewController()
        sut.analytics = Analytics()
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }
}
