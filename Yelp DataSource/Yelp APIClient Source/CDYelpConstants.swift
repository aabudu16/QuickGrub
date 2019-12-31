//
//  CustomerReviewTableViewCell.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/31/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

let CDYelpFusionKitBundleIdentifier = "com.christopherdehaan.CDYelpFusionKit"

struct CDYelpURL {
    static let oAuth    = "https://api.yelp.com/"
    static let base     = "https://api.yelp.com/v3/"
    static let deepLink = "yelp4:"
    static let web      = "https://yelp.com/"
}

struct CDYelpDefaults {
    static let accessToken = "CDYelpAccessToken"
    static let expiresIn = "CDYelpExpiresIn"
}
