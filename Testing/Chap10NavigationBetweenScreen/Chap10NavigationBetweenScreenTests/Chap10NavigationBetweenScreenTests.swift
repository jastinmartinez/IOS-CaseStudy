//
//  Chap10NavigationBetweenScreenTests.swift
//  Chap10NavigationBetweenScreenTests
//
//  Created by Jastin on 29/8/23.
//

import XCTest
@testable import Chap10NavigationBetweenScreen

final class Chap10NavigationBetweenScreenTests: XCTestCase {

    
    func test_navigationControllerIsSet_WithRootViewController() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let sut: UINavigationController = mainStoryBoard.instantiateViewController(identifier:  "NavController")
        XCTAssertNotNil(sut.topViewController as? ViewController)
    }
    
    func test_pushNavigationFromCode() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let nav: UINavigationController = mainStoryBoard.instantiateViewController(identifier:  "NavController")
        let sut = nav.topViewController as! ViewController
        sut.loadViewIfNeeded()
        sut.codePushButton.sendActions(for: .touchUpInside)
        RunLoop.current.run(until: Date())
        XCTAssertNotNil(sut.navigationController?.viewControllers.last as? CodeNextViewController)
    }
}
