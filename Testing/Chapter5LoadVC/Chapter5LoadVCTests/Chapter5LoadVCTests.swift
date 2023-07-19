//
//  Chapter5LoadVCTests.swift
//  Chapter5LoadVCTests
//
//  Created by Jastin on 17/7/23.
//

import XCTest
@testable import Chapter5LoadVC

final class Chapter5LoadVCTests: XCTestCase {
    
    func test_ViewControllerFromStoryBoard_Init_SholdInstantiateOutlets() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = sb.instantiateViewController(withIdentifier: "MainViewController") as! ViewController
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.someValueLabel)
    }
    
    func test_ViewControllerFromXIB_Init_SholdInstantiateOutlets() {
        let sut = XIBViewController()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.label)
    }
    
    func test_ViewController_Init_SholdInstantiate() {
        let sut = ManualViewController(holdData: "aaa")
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.holdData, "viewDidLoad")
    }
    
}
