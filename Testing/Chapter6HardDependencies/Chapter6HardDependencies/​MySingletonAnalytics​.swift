//
//  ​MySingletonAnalytics​.swift
//  Chapter6HardDependencies
//
//  Created by Jastin on 20/7/23.
//

import Foundation


class MySingletonAnalytics {
    
    private static let instance = MySingletonAnalytics()
    
#if DEBUG
    static var stubbedInstance: MySingletonAnalytics?
#endif
    
    static var shared: MySingletonAnalytics {
#if DEBUG
        if let stubbedInstance = stubbedInstance {
            return stubbedInstance
        }
#endif
        return instance
    }
    
    func track(event: String) {
        Analytics.shared.track(event: event)
        
        if self !== MySingletonAnalytics.instance {
            print(">> Not the MySingletonAnalytics singleton")
        }
    }
}



