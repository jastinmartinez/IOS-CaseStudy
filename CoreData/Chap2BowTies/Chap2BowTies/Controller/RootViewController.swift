//
//  RootViewController.swift
//  Chap2BowTies
//
//  Created by Jastin on 17/9/23.
//

import UIKit

class RootViewController: UIViewController {
    
    private let bowTieSegmentedControl: UISegmentedControl = {
        let items = ["R", "O", "Y", "G", "B", "I", "V"]
        let xSegumentedControl = UISegmentedControl(items: items)
        xSegumentedControl.selectedSegmentIndex = 0
        xSegumentedControl.translatesAutoresizingMaskIntoConstraints = false
        return xSegumentedControl
    }()
    
    private let bowImageView: UIImageView = {
        let xImageView = UIImageView()
        xImageView.backgroundColor = .lightGray
        xImageView.translatesAutoresizingMaskIntoConstraints = false
        return xImageView
    }()
    
    private lazy var ratingLabel: UILabel = self.labelBuilder(placeHolder: "Rating:")
    private lazy var ratingValueLabel: UILabel = self.labelBuilder(placeHolder: "4/5")
    private lazy var numberOfTimeLabel: UILabel = self.labelBuilder(placeHolder: "# of times worn:")
    private lazy var numberOfTimeValueLabel: UILabel = self.labelBuilder(placeHolder: "5")
    private lazy var lastWornLabel: UILabel = self.labelBuilder(placeHolder: "Last worn:")
    private lazy var lastWornValueLabel: UILabel = self.labelBuilder(placeHolder: "06/25/14")
    private lazy var favoriteLabel: UILabel = self.labelBuilder(placeHolder: "*Favorite*")
    private lazy var bowTieTitleLabel: UILabel = self.labelBuilder(placeHolder: "Bow Tie Name Label",
                                                                   fontSize: 16,
                                                                   isBold: true)
    private lazy var wearButton: UIButton = self.buttonBuilder(name: "Wear")
    private lazy var rateButton: UIButton = self.buttonBuilder(name: "Rate")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onCreate()
    }
    
    private func onCreate() {
        self.viewLayout()
        self.setLayoutConstraint()
    }
    
    private func viewLayout() {
        self.view.backgroundColor = .white
    }
    
    private func labelBuilder(placeHolder: String,
                              fontSize: CGFloat = 12.0,
                              isBold: Bool = false) -> UILabel {
        let xLabel = UILabel()
        xLabel.translatesAutoresizingMaskIntoConstraints = false
        xLabel.text = placeHolder
        xLabel.font = .systemFont(ofSize: fontSize,
                                  weight: isBold ? .bold : .regular)
        return xLabel
    }
    
    private func buttonBuilder(name: String) -> UIButton {
        let xButton = UIButton(type: .system)
        xButton.translatesAutoresizingMaskIntoConstraints = false
        xButton.setTitle(name, for: .normal)
        return xButton
    }
    
    fileprivate func setLayoutConstraint() {
        self.view.addSubview(self.bowTieSegmentedControl)
        NSLayoutConstraint.activate([self.bowTieSegmentedControl.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
                                     self.bowTieSegmentedControl.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor),
                                     self.bowTieSegmentedControl.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor)])
        
        self.view.addSubview(self.bowImageView)
        NSLayoutConstraint.activate([self.bowImageView.topAnchor.constraint(equalTo: self.bowTieSegmentedControl.bottomAnchor, constant: 10),
                                     self.bowImageView.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor),
                                     self.bowImageView.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor),
                                     self.bowImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2)])
        
        self.view.addSubview(self.bowTieTitleLabel)
        NSLayoutConstraint.activate([self.bowTieTitleLabel.topAnchor.constraint(equalTo: self.bowImageView.bottomAnchor, constant: 10),
                                     self.bowTieTitleLabel.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor),
                                     self.bowTieTitleLabel.rightAnchor.constraint(lessThanOrEqualTo: self.view.layoutMarginsGuide.rightAnchor)])
        
        let ratingStack = self.stackBuilder(arrangedSubviews: [self.ratingLabel,
                                                               self.ratingValueLabel],
                                            relativeView: self.bowTieTitleLabel)
        
        let numberOfWornTime = self.stackBuilder(arrangedSubviews: [self.numberOfTimeLabel,
                                                                    self.numberOfTimeValueLabel],
                                                 relativeView: ratingStack)
        
        let lastWornStack = self.stackBuilder(arrangedSubviews: [self.lastWornLabel,
                                                                 self.lastWornValueLabel],
                                              relativeView: numberOfWornTime)
        
        self.view.addSubview(self.favoriteLabel)
        NSLayoutConstraint.activate([self.favoriteLabel.topAnchor.constraint(equalTo: lastWornStack.bottomAnchor, constant: 10),
                                     self.favoriteLabel.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor),
                                     self.favoriteLabel.rightAnchor.constraint(lessThanOrEqualTo: self.view.layoutMarginsGuide.rightAnchor)])
        
        let bottomButtonStack = UIStackView(arrangedSubviews: [self.wearButton, self.rateButton])
        bottomButtonStack.translatesAutoresizingMaskIntoConstraints = false
        bottomButtonStack.axis = .horizontal
        bottomButtonStack.distribution = .equalSpacing
        bottomButtonStack.alignment = .fill
        self.view.addSubview(bottomButtonStack)
        NSLayoutConstraint.activate([bottomButtonStack.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -20),
                                     bottomButtonStack.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor, constant: 20),
                                     bottomButtonStack.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor, constant: -20)])
    }
    
    @discardableResult private func stackBuilder(arrangedSubviews: [UIView],
                                                 relativeView: UIView) -> UIStackView {
        let xStackView = UIStackView(arrangedSubviews: arrangedSubviews)
        xStackView.translatesAutoresizingMaskIntoConstraints = false
        xStackView.axis = .horizontal
        xStackView.distribution = .fill
        xStackView.alignment = .fill
        xStackView.spacing = 5
        self.view.addSubview(xStackView)
        NSLayoutConstraint.activate([xStackView.topAnchor.constraint(equalTo: relativeView.bottomAnchor, constant: 10),
                                     xStackView.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor),
                                     xStackView.rightAnchor.constraint(lessThanOrEqualTo: self.view.layoutMarginsGuide.rightAnchor)])
        return xStackView
    }
}
