//
//  Chap10NavigationBetweenScreenTests.swift
//  Chap10NavigationBetweenScreenTests
//
//  Created by Jastin on 29/8/23.
//

import XCTest
@testable import Chap10NavigationBetweenScreen

final class Chap10NavigationBetweenScreenTests: XCTestCase {
    
    private var sut: ViewController!
    
    override func setUp() {
        self.setSutAndLoadViewIfNeed()
    }
    
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func test_pushNavigationFromCode_ReturnCodeNextViewController() {
        self.tap(self.sut.codePushButton)
        XCTAssertNotNil(sut.navigationController?.viewControllers.last as? CodeNextViewController)
    }
    
    func test_pushNavigationFromCodePassValue_ShouldReturnCCodeNextViewControllerWithValue() {
        self.tap(self.sut.codePushButton)
        let codeNextViewController = sut.navigationController?.viewControllers.last as? CodeNextViewController
        XCTAssertEqual(codeNextViewController?.label.text, "Push from code")
    }
    
    private func navigationControllerFactory() -> UINavigationController {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryBoard.instantiateViewController(identifier:  "NavController")
    }
    
    private func tap(_ button: UIButton) {
        button.sendActions(for: .touchUpInside)
        self.executeRunLoop()
    }
    
    private func setSutAndLoadViewIfNeed() {
        let nav = self.navigationControllerFactory()
        self.sut = nav.topViewController as? ViewController
        self.sut.loadViewIfNeeded()
    }
    
    private func executeRunLoop() {
        RunLoop.current.run(until: Date())
    }
}
