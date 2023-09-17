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
        xSegumentedControl.translatesAutoresizingMaskIntoConstraints = false
        return xSegumentedControl
    }()
    
    private let bowImageView: UIImageView = {
        let xImageView = UIImageView()
        xImageView.translatesAutoresizingMaskIntoConstraints = false
        return xImageView
    }()
    
    private lazy var ratingLabel: UILabel = self.labelBuilder(placeHolder: "Rating")
    private lazy var ratingValueLabel: UILabel = self.labelBuilder(placeHolder: "4/5")
    private lazy var numberOfTimeLabel: UILabel = self.labelBuilder(placeHolder: "# of times worn:")
    private lazy var numberOfTimeValueLabel: UILabel = self.labelBuilder(placeHolder: "5")
    private lazy var lastWornLabel: UILabel = self.labelBuilder(placeHolder: "Last worn:")
    private lazy var lastWornValueLabel: UILabel = self.labelBuilder(placeHolder: "06/25/14")
    private lazy var favoriteLabel: UILabel = self.labelBuilder(placeHolder: "*Favorite*")
    private lazy var bowTieTitleLabel: UILabel = self.labelBuilder(placeHolder: "Bow Tie Name Label",
                                                                   fontSize: 16,
                                                                   isBold: true)
    
    private func labelBuilder(placeHolder: String,
                              fontSize: CGFloat = 12.0,
                              isBold: Bool = false) -> UILabel {
        let xLabel = UILabel()
        xLabel.translatesAutoresizingMaskIntoConstraints = false
        xLabel.text = placeHolder
        xLabel.font = .systemFont(ofSize: fontSize,
                                  weight: isBold ? .bold : .black)
        return xLabel
    }
    
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
