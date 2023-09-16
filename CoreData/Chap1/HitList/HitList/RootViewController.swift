//
//  RootViewController.swift
//  HitList
//
//  Created by Jastin on 16/9/23.
//

import UIKit

class RootViewController: UIViewController {
    
    private let hitListTableView: UITableView = {
        let xTableView = UITableView()
        xTableView.backgroundColor = .white
        xTableView.register(UITableViewCell.self, forCellReuseIdentifier: "hitListCell")
        xTableView.translatesAutoresizingMaskIntoConstraints = false
        return xTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onCreate()
    }
    
    private func onCreate() {
        self.setViewTitle()
        self.setUpAddNewButton()
        self.setUpHitListTableView()
    }
    
    private func setViewTitle() {
        self.title = "The List"
    }
    
    private func setUpHitListTableView() {
        self.view.addSubview(self.hitListTableView)
        NSLayoutConstraint.activate([self.hitListTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     self.hitListTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                                     self.hitListTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                                     self.hitListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
    
    private func setUpAddNewButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(self.addNewActionButton(_:)))
    }
    
    @objc private func addNewActionButton(_ action: UIBarItem) {
        // Action
    }
}
