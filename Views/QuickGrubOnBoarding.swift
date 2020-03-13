//
//  QuickGrubOnBoarding.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 2/19/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit


class QuickGrubOnBoarding: UIView {
    
     //MARK: -- Properties 2
    
    //MARK: -- Creates computed property to hold current page index 12
    var currentPage: Int {
        return Int(calculateCurrentPosition())
    }
    var pageCount = 0
   weak var onBoardOverlay: QuickGrubOnboardOverlay?
    
    //MARK: -- Create instance of delegate and dataSource 4
    weak var dataSource: QuickGrubOnboardDataSource?
    weak var delegate: QuickGrubOnboardDelegate?
    
    //MARK:-- Objects
    //MARK: -- Creates a Scrollview 1
    lazy var containerView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.bounces = false
        return scrollView
    }()
    
    //MARK: -- LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    //MARK:-- func to handle the pageControl events during tapped 10
    @objc func handlePageControllerTapped(_ sender: UIPageControl) {
        let pageIndex = sender.currentPage
        // calls the go to page func to animate and present the appropriate view by internally incrementing and decrimenting index
        goToPage(index: pageIndex, animated: true)
        
    }
    
    //MARK:-- Used to layout the subview of the class 7
    override func layoutSubviews() {
        super.layoutSubviews()
        configureScrollView()
        setScrollViewDelegate()
        setUpAllPages()
        setUpOverlayView()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- Creates func to calculate current position of scrollview 11
    private func calculateCurrentPosition() -> CGFloat {
        let width = containerView.bounds.width
        let contentOffSet = containerView.contentOffset.x
        return contentOffSet / width
    }
    
    //MARK: -- 5   now 13
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
                    if let color = dataSource.quickGrubOnboardBackgroundColorFor(self, atIndex: index){
                        eachView.backgroundColor = color
                    // add to scroll view subview
                    containerView.addSubview(eachView)
                    // Create a frame to fit each view for there index by multiplying the frame by the amount of views it has
                    var viewFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                    viewFrame.origin.x = self.frame.width * CGFloat(index)
                    eachView.frame = viewFrame
                }
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


//MARK: Creates an extenstion on QuickGrubOnBoarding to handle Scrollview delgate 12
extension QuickGrubOnBoarding: UIScrollViewDelegate{
   //MARK: Creates an extenstion on QuickGrubOnBoarding to handle Scrollview delgate 13
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPosition = calculateCurrentPosition()
        onBoardOverlay?.currentPage(index: Int(currentPosition))
        
    // allows us to modify properies of the overlay view based on the index we are currently in
        if let overlay = onBoardOverlay {
            dataSource?.quickGrubOnboardOverlayForPosition(self, overlay: overlay, for: Double(currentPosition))
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPosition = calculateCurrentPosition()
        onBoardOverlay?.currentPage(index: Int(currentPosition))
    }
    
}
