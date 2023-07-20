//
//  Analytics.swift
//  Chapter6HardDependencies
//
//  Created by Jastin on 20/7/23.
//

import Foundation

class Analytics {
    static let shared = Analytics()
    
    func track(event: String) {
        print(">> " + event)
        
        if self !== Analytics.shared {
            print(">> ...Not the Analytics singleton")
        }
    }
}
