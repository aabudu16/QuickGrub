//
//  CustomLayer.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

struct CustomLayer{
   static let shared = CustomLayer()
   func createCustomlayer(layer:CALayer){
      layer.cornerRadius = 25
       layer.borderWidth = 2
       layer.borderColor = UIColor.black.cgColor
       layer.masksToBounds = true
       layer.shadowColor = UIColor.black.cgColor
       layer.shadowOffset = CGSize(width: 0, height: 5.0)
       layer.shadowRadius = 20.0
       layer.shadowOpacity = 0.5
       layer.masksToBounds = false
   }
}
