//
//  RootViewController.swift
//  HitList
//
//  Created by Jastin on 16/9/23.
//

import UIKit

class RootViewController: UIViewController {
    
    private let hitistTableView: UITableView = {
        let xTableView = UITableView()
        xTableView.backgroundColor = .white
        xTableView.translatesAutoresizingMaskIntoConstraints = false
        return xTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onCreate()
    }
    
    private func onCreate() {
        self.view.addSubview(self.hitistTableView)
        NSLayoutConstraint.activate([self.hitistTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     self.hitistTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                                     self.hitistTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                                     self.hitistTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
}
