//
//  FilterModel.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/13/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

struct FilterModel{
    let sortBy:CDYelpBusinessSortType
    let price:[CDYelpPriceTier]
    let limit:Int
    let distance:Int
}
