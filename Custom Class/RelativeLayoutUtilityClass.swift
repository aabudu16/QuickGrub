//
//  RelativeLayoutUtilityClass.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/7/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit
// This class is used to set relative height and width based on the frame of the screen
class RelativeLayoutUtilityClass {

    var heightFrame: CGFloat?
    var widthFrame: CGFloat?

    init(referenceFrameSize: CGSize){
        heightFrame = referenceFrameSize.height
        widthFrame = referenceFrameSize.width
    }

    func relativeHeight(multiplier: CGFloat) -> CGFloat{

        return multiplier * self.heightFrame!
    }

    func relativeWidth(multiplier: CGFloat) -> CGFloat{
        return multiplier * self.widthFrame!

    }
}
