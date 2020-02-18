//
//  Protocol.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/30/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

protocol CollectionViewCellDelegate: AnyObject {
    func addSelectedFood(tag: Int)
    func handleShortCut(tag: Int)
}



protocol FoldingCellDelegate: AnyObject {
    func navigateToDestination(tag: Int)
    func handleFavorite(tag:Int)
    func navigateToDetailedViewController(tag: Int)
}

//protocol NavigateToRestaurantDetailVCDelegate: AnyObject {
//    func navigateToDetailedViewController(tag: Int)
//}

protocol YelpCustomerProfileDelegate:AnyObject{
    func viewCustomerProfile(tag:Int)
}

protocol MoreYelpReviewDelegate:AnyObject{
    func viewMoreYelpReviews(tag:Int)
}
