//
//  FilterModel.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/13/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

struct FilterModel{
    let sortBy:CDYelpBusinessSortType?
    let price:[CDYelpPriceTier]?
    let limit:Int
    let distance:Int
    let openNow:Bool?
    
}

struct GenericParameter{
  static let genericSettingParameter = FilterModel(sortBy: .bestMatch, price: [.oneDollarSign, .twoDollarSigns, .threeDollarSigns, .fourDollarSigns], limit: 20, distance: 200, openNow: true)
}

struct SelectedCategoriesModel {
    let categories:[CDYelpCategoryAlias]
}
