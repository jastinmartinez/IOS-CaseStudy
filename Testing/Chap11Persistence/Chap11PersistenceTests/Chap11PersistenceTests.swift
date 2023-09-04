//
//  Chap11PersistenceTests.swift
//  Chap11PersistenceTests
//
//  Created by Jastin on 3/9/23.
//

import XCTest
@testable import Chap11Persistence

final class Chap11PersistenceTests: XCTestCase {

    private var sut: ViewController!
    private var fakeUserDefault: FakeUserDefault!
    private var key: ViewController.userDefaultsKeys!
    
    override func setUp() {
        self.sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController")
        self.fakeUserDefault = FakeUserDefault()
        self.sut.setUserDefaultProtocol(self.fakeUserDefault)
        self.key = .count
        super.setUp()
    }
    
    override func tearDown() {
        self.sut = nil
        self.fakeUserDefault = nil
        self.key = nil
        super.tearDown()
    }
    
    func test_ViewDidLoad_WithEmptyUserDefaults_ShouldShowZeroCounterLabel() {
        self.sut.loadViewIfNeeded()
        XCTAssertEqual(sut.counterLabel.text, "0")
    }
    
    func test_ViewDidLoad_WithDefaultValue7_ShouldShow7InCounterLabel() {
        self.fakeUserDefault.set(7, forKey: self.key.rawValue)
        self.sut.loadViewIfNeeded()
        XCTAssertEqual(sut.counterLabel.text, "7")
    }
    
    func test_tappingButton_with1AsValueSaved_ShouldWrite2() {
        self.fakeUserDefault.set(1, forKey: self.key.rawValue)
        self.sut.loadViewIfNeeded()
        self.sut.incrementButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(self.fakeUserDefault.integer(forKey: self.key.rawValue), 2)
    }
    
    func test_tappingButton_with1AsValueSaved_ShouldShowLabelIncrementWithValue2() {
        self.fakeUserDefault.set(1, forKey: self.key.rawValue)
        self.sut.loadViewIfNeeded()
        self.sut.incrementButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(self.sut.counterLabel.text, "2")
    }
}

final class FakeUserDefault: UserDefaultProtocol {
    
    private var dic = [String: Int]()
    
    func integer(forKey defaultName: String) -> Int {
        return self.dic[defaultName] ?? 0
    }
    
    func set(_ value: Int, forKey key: String) {
        self.dic[key] = value
    }
}
