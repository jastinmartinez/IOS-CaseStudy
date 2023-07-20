//
//  InstanceInitializersViewController.swift
//  Chapter6HardDependencies
//
//  Created by Jastin on 20/7/23.
//

import UIKit

class InstanceInitializersViewController: UIViewController {

    private let analytics: Analytics
    
    init(analytics: Analytics = Analytics.shared) {
        self.analytics = analytics
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
       fatalError(">> Fail to create \(type(of: self))")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.analytics.track(event: "viewDidAppear - \(type(of: self))")
    }
}
