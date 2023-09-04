//
//  ViewController.swift
//  Chap11Persistence
//
//  Created by Jastin on 3/9/23.
//

import UIKit

protocol UserDefaultProtocol {
    func integer(forKey defaultName: String) -> Int
    func set(_ value: Int, forKey key: String)
}
extension UserDefaults: UserDefaultProtocol { }

class ViewController: UIViewController {
    
    @IBOutlet private (set) weak var counterLabel: UILabel!
    @IBOutlet private(set) weak var incrementButton: UIButton!
    private(set) var userDefaults: UserDefaultProtocol = UserDefaults.standard
    enum userDefaultsKeys: String {
        case count
    }
    
    private(set) var count: Int = 0  {
        didSet {
            self.whenDidSetValue()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialValueFromStorage()
    }
    
    func setUserDefaultProtocol(_ userDefaultProtocol: UserDefaultProtocol) {
        self.userDefaults = userDefaultProtocol
    }
    
    private func setInitialValueFromStorage() {
        self.count = self.userDefaults.integer(forKey: userDefaultsKeys.count.rawValue)
    }
    
    private func whenDidSetValue() {
        self.counterLabel.text = "\(count)"
        self.userDefaults.set(count, forKey: userDefaultsKeys.count.rawValue)
    }
    
    @IBAction private func incrementCounterButtonTap() {
        self.count += 1
    }
}


