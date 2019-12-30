//
//  Protocol.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/30/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

protocol FoldingCellDelegate: AnyObject {
    func navigateToDestination(tag: Int)
}

protocol NavigateToRestaurantDetailVCDelegate: AnyObject {
    func navigateToDetailedViewController(tag: Int)
}
