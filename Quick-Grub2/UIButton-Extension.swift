//
//  UIButton-Extension.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    public convenience init(alpha:CGFloat, contentMode: UIView.ContentMode){
        self.init()
        self.alpha = alpha
        self.contentMode = contentMode
    }
}
