//
//  RotationView.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 5/1/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

// MARK: RotatedView

open class RotatedView: UIView {
    
     enum Const {
        static let rotationX = "rotation.x"
        static let transformRotationX = "transform.rotation.x"
    }
    
    var hiddenAfterAnimation = false
    var backView: RotatedView?
    
    func addBackView(_ height: CGFloat, color: UIColor) {
        let view = RotatedView(frame: CGRect.zero)
        view.backgroundColor = color
        view.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        view.layer.transform = view.transform3d()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        backView = view
        
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: height))
        self.addConstraints([ NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: self.bounds.size.height - height + height / 2), NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
                              
                              NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)])
    }
}
