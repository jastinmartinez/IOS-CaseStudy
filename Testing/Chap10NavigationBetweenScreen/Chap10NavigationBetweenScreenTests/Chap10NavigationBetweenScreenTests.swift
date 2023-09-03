//
//  Chap10NavigationBetweenScreenTests.swift
//  Chap10NavigationBetweenScreenTests
//
//  Created by Jastin on 29/8/23.
//

import XCTest
@testable import Chap10NavigationBetweenScreen

final class Chap10NavigationBetweenScreenTests: XCTestCase {
    
    private var nav: SpyNavigationController!
    private var sut: ViewController!
    
    override func setUp() {
        self.setSutAndLoadViewIfNeed()
        super.setUp()
    }
    
    override func tearDown() {
        self.sut = nil
        self.nav = nil
        super.tearDown()
    }
    
    func test_pushNavigationFromCode_ReturnCodeNextViewController() {
        self.tap(self.sut.codePushButton)
        self.executeRunLoop()
        XCTAssertNotNil(sut.navigationController?.viewControllers.last as? CodeNextViewController)
    }
    
    func test_pushNavigationFromCodePassValue_ShouldReturnCCodeNextViewControllerWithValue() {
        self.tap(self.sut.codePushButton)
        self.executeRunLoop()
        let codeNextViewController = sut.navigationController?.viewControllers.last as? CodeNextViewController
        XCTAssertEqual(codeNextViewController?.label.text, "Push from code")
    }
    
    func test_pushViewControllerFromCode_ShouldReturnCodeNextViewControllerAnimated() {
        self.tap(self.sut.codePushButton)
        self.executeRunLoop()
        XCTAssertTrue(self.nav.pushViewControllerAnimatedList.count == 2)
    }
    
    private func navigationControllerFactory() -> SpyNavigationController! {
        let nav: UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NavController")
        guard let viewController = nav.topViewController as? ViewController else {
            XCTFail("the top viewcontroller is not the expected")
            return nil
        }
        let spyNavigationController = SpyNavigationController(rootViewController: viewController)
        return spyNavigationController
    }
    
    private func tap(_ button: UIButton) {
        button.sendActions(for: .touchUpInside)
    }
    
    private func setSutAndLoadViewIfNeed() {
        self.nav = self.navigationControllerFactory()
        self.sut = self.nav.topViewController as? ViewController
        self.sut.loadViewIfNeeded()
    }
    
    private func executeRunLoop() {
        RunLoop.current.run(until: Date())
    }
}

private final class SpyNavigationController: UINavigationController {
    private (set) var pushViewControllerAnimatedList = [Bool]()
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        self.pushViewControllerAnimatedList.append(animated)
    }
}

