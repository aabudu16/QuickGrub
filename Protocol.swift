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
    
    func swiftyOnboardBackgroundColorFor(_ quickGrubOnBoarding: QuickGrubOnBoarding, atIndex index: Int) -> UIColor?
    func swiftyOnboardNumberOfPages(_ quickGrubOnBoarding: QuickGrubOnBoarding) -> Int
    func swiftyOnboardViewForBackground(_ quickGrubOnBoarding: QuickGrubOnBoarding) -> UIView?
    func swiftyOnboardPageForIndex(_ quickGrubOnBoarding: QuickGrubOnBoarding, index: Int) -> QuickGrubOnBoardingPage?
    func swiftyOnboardViewForOverlay(_ quickGrubOnBoarding: QuickGrubOnBoarding) -> QuickGrubOnboardOverlay?
    func swiftyOnboardOverlayForPosition(_ quickGrubOnBoarding: QuickGrubOnBoarding, overlay: QuickGrubOnboardOverlay, for position: Double)
    
}

extension QuickGrubOnboardDataSource{
    func swiftyOnboardBackgroundColorFor(_ quickGrubOnBoarding: QuickGrubOnBoarding,atIndex index: Int)->UIColor?{
          return nil
      }

      func swiftyOnboardViewForBackground(_ quickGrubOnBoarding: QuickGrubOnBoarding) -> UIView? {
          return nil
      }

      func swiftyOnboardOverlayForPosition(_ quickGrubOnBoarding: QuickGrubOnBoarding, overlay: QuickGrubOnboardOverlay, for position: Double) {}

      func swiftyOnboardViewForOverlay(_ quickGrubOnBoarding: QuickGrubOnBoarding) -> QuickGrubOnboardOverlay? {
          return QuickGrubOnboardOverlay()
      }
}

 protocol QuickGrubOnboardDelegate: AnyObject {
    
    func quickGrubOnBoarding(_ quickGrubOnBoarding: QuickGrubOnBoarding, currentPage index: Int)
    func quickGrubOnBoarding(_ quickGrubOnBoarding: QuickGrubOnBoarding, leftEdge position: Double)
    func quickGrubOnBoarding(_ quickGrubOnBoarding: QuickGrubOnBoarding, tapped index: Int)
    
}
