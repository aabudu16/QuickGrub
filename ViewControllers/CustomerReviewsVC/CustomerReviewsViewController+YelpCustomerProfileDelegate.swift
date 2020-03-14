//
//  CustomerReviewsViewController+YelpCustomerProfileDelegate.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension CustomerReviewsViewController:YelpCustomerProfileDelegate{
    func viewCustomerProfile(tag: Int) {
        let profile = customerReviews[tag]
        
        guard let profileURL = profile.user?.profileUrl else {
            self.showAlert(alertTitle: "Sorry", alertMessage: "Cant access \(profile.user?.name ?? "the profile") link on YELP.", actionTitle: "OK")
            return
        }
        self.showSafariVC(for: profileURL)
    }
}
