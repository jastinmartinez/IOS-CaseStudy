//
//  OverrideViewController.swift
//  Chapter6HardDependencies
//
//  Created by Jastin on 20/7/23.
//

import UIKit

class OverrideViewController: UIViewController {
    func analytics() -> Analytics {
        return Analytics.shared
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        analytics().track(event: "viewDidAppear - \(type(of: self))")
    }
}
