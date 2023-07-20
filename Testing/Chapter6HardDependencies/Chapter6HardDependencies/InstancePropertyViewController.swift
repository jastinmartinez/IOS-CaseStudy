//
//  InstancePropertyViewController.swift
//  Chapter6HardDependencies
//
//  Created by Jastin on 20/7/23.
//

import UIKit

class InstancePropertyViewController: UIViewController {

    lazy var analytics = Analytics.shared
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.analytics.track(event: "viewDidAppear - \(type(of: self))")
    }
}
