//
//  Chap8TestingButtonTapsTests.swift
//  Chap8TestingButtonTapsTests
//
//  Created by Jastin on 31/7/23.
//

import XCTest
@testable import Chap8TestingButtonTaps

final class Chap8TestingButtonTapsTests: XCTestCase {
    
    private var sut: ViewController!
    
    override func setUp() {
        self.sut  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController
        super.setUp()
    }
    
    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func test_TappingButton() {
        sut.loadViewIfNeeded()
    }
    
    func test_TappingButton_ShouldPerfromTap() {
        sut.loadViewIfNeeded()
        sut.button.sendActions(for: .touchUpInside)
    }
}
