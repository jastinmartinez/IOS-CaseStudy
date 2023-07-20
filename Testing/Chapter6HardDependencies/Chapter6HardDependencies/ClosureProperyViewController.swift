//
//  ClosureProperyViewController.swift
//  Chapter6HardDependencies
//
//  Created by Jastin on 20/7/23.
//

import UIKit

class ClosureProperyViewController: UIViewController {

    var analytis: () -> Analytics = { return Analytics.shared }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.analytis().track(event: "viewDidAppear - \(type(of: self))")
    }
}
