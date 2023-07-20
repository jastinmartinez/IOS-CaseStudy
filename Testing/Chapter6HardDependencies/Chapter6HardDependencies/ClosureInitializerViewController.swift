//
//  ClosureInitializerViewController.swift
//  Chapter6HardDependencies
//
//  Created by Jastin on 20/7/23.
//

import UIKit

class ClosureInitializerViewController: UIViewController {
    
    private let makeAnalytics: () -> Analytics
    
    init(makeAnalytics: @escaping () -> Analytics) {
        self.makeAnalytics = makeAnalytics
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(">> fail creating \(type(of: self))")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeAnalytics().track(event: "viewDidAppear - \(type(of: self))")
    }
}
