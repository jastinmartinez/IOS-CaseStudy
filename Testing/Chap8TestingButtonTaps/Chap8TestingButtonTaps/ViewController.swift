//
//  ViewController.swift
//  Chap8TestingButtonTaps
//
//  Created by Jastin on 31/7/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private(set) weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction private func buttonTap(_ sender: UIButton) {
        print(">> button was tapped")
    }
    
}

