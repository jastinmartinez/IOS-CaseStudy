//
//  ViewController.swift
//  Chap10NavigationBetweenScreen
//
//  Created by Jastin on 29/8/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private(set) weak var codePushButton: UIButton!
    @IBOutlet private(set) weak var codeModalButton: UIButton!
    @IBOutlet private(set) weak var seguePushButton: UIButton!
    @IBOutlet private(set) weak var segueModalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        enum SegueConstant: String {
            case push
            case modal
        }
        if let identifier = segue.identifier, let identifier = SegueConstant(rawValue: identifier) {
            guard let segueViewController = segue.destination as? SegueViewController else {
                return
            }
            switch identifier {
            case .push:
                segueViewController.setText("Push from segue")
            case .modal:
                segueViewController.setText("Modal from segue")
            }
        }
    }
    
    private func codeNextViewControllerFactory(text: String) -> CodeNextViewController {
        return CodeNextViewController(text: text)
    }
    
    @IBAction private func pushCodeNextViewController() {
        let nextViewController = self.codeNextViewControllerFactory(text: "Push from code")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction private func presentCodeNextViewController() {
        let nextViewController = self.codeNextViewControllerFactory(text: "Modal from code")
        self.present(nextViewController, animated: true)
    }
}

final class CodeNextViewController: UIViewController {
     let label: UILabel = {
        let xLabel = UILabel()
        xLabel.translatesAutoresizingMaskIntoConstraints = false
        return xLabel
    }()
    
    init(text: String) {
        self.label.text = text
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
        self.view.backgroundColor = .white
        self.view.addSubview(self.label)
        NSLayoutConstraint.activate([self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     self.label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)])
    }
}

final class SegueViewController: UIViewController {
    private let label: UILabel = {
        let xLabel = UILabel()
        xLabel.translatesAutoresizingMaskIntoConstraints = false
        return xLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onCreate()
    }
    
    func setText(_ text: String) {
        self.label.text = text
    }
    
    private func onCreate() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.label)
        NSLayoutConstraint.activate([self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     self.label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)])
    }
}

