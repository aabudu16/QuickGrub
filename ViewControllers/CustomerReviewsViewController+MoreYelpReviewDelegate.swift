//
//  CustomerReviewsViewController+MoreYelpReviewDelegate.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension CustomerReviewsViewController:MoreYelpReviewDelegate{
    func viewMoreYelpReviews(tag: Int) {
        let fullReview = customerReviews[tag]
        
        guard let review = fullReview.url else {
            self.showAlert(alertTitle: "Sorry", alertMessage: "Cant access \(fullReview.user?.name ?? "the full review") link on YELP.", actionTitle: "OK")
            return
        }
        self.showSafariVC(for: review)
    }
}
