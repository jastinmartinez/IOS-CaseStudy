//
//  RootViewController.swift
//  BeforeAutoLayout
//
//  Created by Jastin on 24/5/23.
//

import UIKit

class RootViewController: UIViewController {

    private let greenView: TitleView = {
        let frame = CGRect(x: 50, y: 50, width: 275, height: 150)
        let innerView = TitleView(frame: frame)
        innerView.padding = 10
        innerView.autoresizingMask = [.flexibleWidth,
                                      .flexibleLeftMargin,
                                      .flexibleBottomMargin,
                                      .flexibleRightMargin]
        innerView.backgroundColor = .green
        return innerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onCreate()
    }
    
    fileprivate func onCreate() {
        self.setViewConfiguration()
        self.setUpViews()
    }
    
    fileprivate func setViewConfiguration() {
        self.view.backgroundColor = .white
    }
    
    fileprivate func setUpViews() {
        self.view.addSubview(self.greenView)
    }
}


@IBDesignable
final class TitleView: UIView {
    
   @IBInspectable var padding: CGFloat = 25.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    private let blueView: UIView = {
        let innerView = UIView()
        innerView.backgroundColor = .blue
        return innerView
    }()
    
    private let redView: UIView = {
        let innerView = UIView()
        innerView.backgroundColor = .red
        return innerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpView() {
        self.addSubview(self.blueView)
        self.addSubview(self.redView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.sizeConfiguration()
    }
    
    private func sizeConfiguration() {
        let containerHeight = self.bounds.height
        let containerWidth = self.bounds.width
    
        
        let numberOfItems: CGFloat = 2
        let itemWidth = (containerWidth - (numberOfItems + 1) * self.padding) / numberOfItems
        let itemHeight = containerHeight - numberOfItems * self.padding
        
        self.blueView.frame = CGRect(x: self.padding,
                                     y: self.padding,
                                     width: itemWidth,
                                     height: itemHeight)
        
        self.redView.frame = CGRect(x: 2 * self.padding + itemWidth,
                                    y: self.padding,
                                    width: itemWidth,
                                    height: itemHeight)
    }
}
