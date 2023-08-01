//
//  ViewController.swift
//  Chap9TestingAlerts
//
//  Created by Jastin on 31/7/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonAlert: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonAlertTap(_ sender: Any) {
        let alertViewController = UIAlertController(title: "What's new?", message: "Nothing But Chill", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print(">> Cancel Action")
        }
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            print(">> Ok Action")
        }
        
        alertViewController.addAction(cancelAction)
        alertViewController.addAction(okAction)
        alertViewController.preferredAction = okAction
        self.present(alertViewController, animated: true)
    }
}

