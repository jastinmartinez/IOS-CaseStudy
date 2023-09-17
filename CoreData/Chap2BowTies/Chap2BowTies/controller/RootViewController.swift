//
//  RootViewController.swift
//  Chap2BowTies
//
//  Created by Jastin on 17/9/23.
//

import UIKit

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onCreate()
    }
    
    private func onCreate() {
        self.viewLayout()
    }
    
    private func viewLayout() {
        self.view.backgroundColor = .white
    }
}

