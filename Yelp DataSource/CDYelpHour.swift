//
//  CustomerReviewTableViewCell.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/31/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import ObjectMapper

public class CDYelpHour: Mappable {

    public var hoursType: String?
    public var open: [CDYelpOpen]?
    public var isOpenNow: Bool?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        hoursType   <- map["hours_type"]
        open        <- map["open"]
        isOpenNow   <- map["is_open_now"]
    }
}
