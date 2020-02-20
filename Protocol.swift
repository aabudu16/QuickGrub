//
//  Protocol.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/30/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

protocol CollectionViewCellDelegate: AnyObject {
    func addSelectedFood(tag: Int)
    func handleShortCut(tag: Int)
}

protocol FoldingCellDelegate: AnyObject {
    func navigateToDestination(tag: Int)
    func handleFavorite(tag:Int)
    func navigateToDetailedViewController(tag: Int)
}

protocol YelpCustomerProfileDelegate:AnyObject{
    func viewCustomerProfile(tag:Int)
}

protocol MoreYelpReviewDelegate:AnyObject{
    func viewMoreYelpReviews(tag:Int)
}


 protocol QuickGrubOnboardDataSource: AnyObject {
    
    func quickGrubOnboardBackgroundColorFor(_ quickGrubOnBoarding: QuickGrubOnBoarding, atIndex index: Int) -> UIColor?
    func quickGrubOnboardNumberOfPages(_ quickGrubOnBoarding: QuickGrubOnBoarding) -> Int
    func quickGrubOnboardPageForIndex(_ quickGrubOnBoarding: QuickGrubOnBoarding, index: Int) -> QuickGrubOnBoardingPage?
    func quickGrubOnboardViewForOverlay(_ quickGrubOnBoarding: QuickGrubOnBoarding) -> QuickGrubOnboardOverlay?
    func quickGrubOnboardOverlayForPosition(_ quickGrubOnBoarding: QuickGrubOnBoarding, overlay: QuickGrubOnboardOverlay, for position: Double)
    
}

extension QuickGrubOnboardDataSource{
      func quickGrubOnboardOverlayForPosition(_ quickGrubOnBoarding: QuickGrubOnBoarding, overlay: QuickGrubOnboardOverlay, for position: Double) {}

      func quickGrubOnboardViewForOverlay(_ quickGrubOnBoarding: QuickGrubOnBoarding) -> QuickGrubOnboardOverlay? {
          return QuickGrubOnboardOverlay()
      }
}

 protocol QuickGrubOnboardDelegate: AnyObject {
    
    func quickGrubOnBoarding(_ quickGrubOnBoarding: QuickGrubOnBoarding, currentPage index: Int)
    func quickGrubOnBoarding(_ quickGrubOnBoarding: QuickGrubOnBoarding, tapped index: Int)
    
}

extension QuickGrubOnboardDelegate {
    func quickGrubOnBoarding(_ quickGrubOnBoarding: QuickGrubOnBoarding, currentPage index: Int){
        
    }
    
    func quickGrubOnBoarding(_ quickGrubOnBoarding: QuickGrubOnBoarding, tapped index: Int){
        
    }
}
