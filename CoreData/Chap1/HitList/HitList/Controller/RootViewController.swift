//
//  RootViewController.swift
//  HitList
//
//  Created by Jastin on 16/9/23.
//

import UIKit

class RootViewController: UIViewController {
    
    private let storageControllerProtocol: StorageControllerProtocol
    private let hitListTableView: UITableView = {
        let xTableView = UITableView()
        xTableView.backgroundColor = .white
        xTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.hitListCell.rawValue)
        xTableView.translatesAutoresizingMaskIntoConstraints = false
        return xTableView
    }()
    
    init(storageControllerProtocol: StorageControllerProtocol) {
        self.storageControllerProtocol = storageControllerProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onCreate()
    }
    
    private func onCreate() {
        self.setViewTitle()
        self.setUpAddNewButton()
        self.setUpHitListTableView()
        self.setHitListTableViewDelegates()
    }
    
    private func setViewTitle() {
        self.title = "The List"
    }
    
    private func setHitListTableViewDelegates() {
        self.hitListTableView.dataSource = self
    }
    
    private func setUpHitListTableView() {
        self.view.addSubview(self.hitListTableView)
        NSLayoutConstraint.activate([self.hitListTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     self.hitListTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                                     self.hitListTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                                     self.hitListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
    
    private func setUpAddNewButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(self.addNewActionButton(_:)))
    }
    
    @objc private func addNewActionButton(_ action: UIBarItem) {
        self.setANameAlertController()
    }
    
    private func setANameAlertController() {
        let alertController = UIAlertController(title: "New Name",
                                                message: "Add a new name",
                                                preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { [unowned self] action in
            guard let textfield = alertController.textFields?.first,
                  let nameToSave = textfield.text else {
                return
            }
            self.storageControllerProtocol.save(name: nameToSave)
            self.hitListTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addTextField()
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        self.present(alertController, animated: true)
    }
}

extension RootViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storageControllerProtocol.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hitListCell = tableView.dequeueReusableCell(withIdentifier: Constant.hitListCell.rawValue, for: indexPath)
        hitListCell.selectionStyle = .none
        hitListCell.textLabel?.text = self.storageControllerProtocol.people[indexPath.row]
        return hitListCell
    }
}

extension RootViewController {
    private enum Constant: String {
        case hitListCell
    }
}
