//
//  QuickGrubOnBoarding.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 2/19/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit


class QuickGrubOnBoarding: UIView {
    
     //MARK: -- Properties
    var pageCount = 0
    var onBoardOverlay: QuickGrubOnboardOverlay?
    var numberOfOnboardPages = [QuickGrubOnBoardingPage]()
    
    weak var dataSource: QuickGrubOnboardDataSource?
    weak var delegate: QuickGrubOnboardDelegate?
    
    //MARK:-- Objects
    lazy var containerView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    //MARK: -- LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureScrollView()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureScrollView() {
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([containerView.topAnchor.constraint(equalTo: self.topAnchor), containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor), containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor), containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
}
