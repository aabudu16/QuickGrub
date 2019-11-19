//
//  UILabel-Extension.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    public convenience init(textAlignment:NSTextAlignment, text:String){
        self.init()
        self.numberOfLines = 0
        self.textColor = .black
        self.text = text
        self.textAlignment = textAlignment
}
}
