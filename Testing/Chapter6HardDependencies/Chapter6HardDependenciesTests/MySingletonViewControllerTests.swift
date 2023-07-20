//
//  Chapter6HardDependenciesTests.swift
//  Chapter6HardDependenciesTests
//
//  Created by Jastin on 20/7/23.
//

import XCTest
@testable import Chapter6HardDependencies

final class MySingletonViewControllerTests: XCTestCase {
  
    override func setUp() {
        super.setUp()
        MySingletonAnalytics.stubbedInstance = MySingletonAnalytics()
    }
    
    override func tearDown() {
        MySingletonAnalytics.stubbedInstance = nil
        super.tearDown()
    }
    
    func test_ViewDidAppear() {
        let sut = MySingletonViewController()
        sut.loadViewIfNeeded()
        sut.viewDidAppear(false)
    }
}
