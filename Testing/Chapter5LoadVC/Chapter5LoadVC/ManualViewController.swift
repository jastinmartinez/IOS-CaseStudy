//
//  ManualViewController.swift
//  Chapter5LoadVC
//
//  Created by Jastin on 18/7/23.
//

import UIKit

class ManualViewController: UIViewController {
    
    var holdData: String
    
    init(holdData: String) {
        self.holdData = holdData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.holdData = ""
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.holdData = "viewDidLoad"
    }
}
