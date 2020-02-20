//
//  QuickGrubOnBoarding.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 2/19/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit


class QuickGrubOnBoarding: UIView , UIScrollViewDelegate{
    
     //MARK: -- Properties 2
    var pageCount = 0
    var onBoardOverlay: QuickGrubOnboardOverlay?
    
    //MARK: -- Create instance of delegate and dataSource 4
    weak var dataSource: QuickGrubOnboardDataSource?
    weak var delegate: QuickGrubOnboardDelegate?
    
    //MARK:-- Objects
    //MARK: -- Creates a Scrollview 2
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
        setScrollViewDelegate()
    }
    
    //MARK:-- Used to layout the subview of the class 7
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpAllPages()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- 5
    private func setScrollViewDelegate(){
        containerView.delegate = self
    }
    
    //MARK: -- set up all pages of the onBoarding views 6
    private func setUpAllPages() {
        // un wrap the dataSource
        if let dataSource = dataSource{
            //get the count of pages from the dataSource when provided
            pageCount = dataSource.quickGrubOnboardNumberOfPages(self)
            // loop through the amount of count to populate the data for each page from the dataSource provided
            for index in 0..<pageCount{
                if let eachView = dataSource.quickGrubOnboardPageForIndex(self, index: index) {
                    // add to scroll view subview
                    containerView.addSubview(eachView)
                    // Create a frame to fit each view for there index by multiplying the frame by the amount of views it has
                    var viewFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                    viewFrame.origin.x = self.frame.width * CGFloat(index)
                    eachView.frame = viewFrame
                }
            }
            // this resizes the container ScrollView to be able to scroll to all the pages added.. Although all the views are on the screen, we wont be able to scroll to see see them.
              containerView.contentSize = CGSize(width: self.frame.width * CGFloat(pageCount), height: self.frame.height)
        }
    }
    
    //MARK: -- Set up the static ovelay page that doesnt move with the siderview
    private func setUpOverlayView() {
        if let dataSource = dataSource {
            if let overlay = dataSource.quickGrubOnboardViewForOverlay(self) {
                overlay.numberOfPages(count: pageCount)
                self.addSubview(overlay)
                let overLayFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                overlay.frame = overLayFrame
                onBoardOverlay = overlay
        
                //MARK:-- add funtion to pagecontroller for when it gets tapped 8
                onBoardOverlay?.pageControl.addTarget(self, action: #selector(handlePageControllerTapped), for: .allTouchEvents)
                
            }
        }
    }
    
    // MARK: -- func to set the sliderView content offset to be the view based on the appropriate index 9
    func goToPage(index: Int, animated:Bool) {
        let index = CGFloat(index)
        containerView.setContentOffset(CGPoint(x: index * self.frame.width, y: 0), animated: animated)
    }
    
    //MARK: create Constraints for scrollview 3
    private func configureScrollView() {
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([containerView.topAnchor.constraint(equalTo: self.topAnchor), containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor), containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor), containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
}
