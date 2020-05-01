//
//  RotationView+Extension.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 5/1/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit
extension RotatedView: CAAnimationDelegate {
    
    func rotatedX(_ angle: CGFloat) {
        var allTransofrom = CATransform3DIdentity
        let rotateTransform = CATransform3DMakeRotation(angle, 1, 0, 0)
        allTransofrom = CATransform3DConcat(allTransofrom, rotateTransform)
        allTransofrom = CATransform3DConcat(allTransofrom, transform3d())
        self.layer.transform = allTransofrom
    }
    
    func transform3d() -> CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = 2.5 / -2000
        return transform
    }
    
    // MARK: animations
    
    func foldingAnimation(_ timing: String, from: CGFloat, to: CGFloat, duration: TimeInterval, delay: TimeInterval, hidden: Bool) {
        
        let rotateAnimation = CABasicAnimation(keyPath: Const.transformRotationX)
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: convertToCAMediaTimingFunctionName(timing))
        rotateAnimation.fromValue = from
        rotateAnimation.toValue = to
        rotateAnimation.duration = duration
        rotateAnimation.delegate = self
        rotateAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.beginTime = CACurrentMediaTime() + delay
        
        self.hiddenAfterAnimation = hidden
        
        self.layer.add(rotateAnimation, forKey: Const.rotationX)
    }
    
    public func animationDidStart(_: CAAnimation) {
        self.layer.shouldRasterize = true
        self.alpha = 1
    }
    
    public func animationDidStop(_: CAAnimation, finished _: Bool) {
        if hiddenAfterAnimation {
            self.alpha = 0
        }
        self.layer.removeAllAnimations()
        self.layer.shouldRasterize = false
        self.rotatedX(CGFloat(0))
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertToCAMediaTimingFunctionName(_ input: String) -> CAMediaTimingFunctionName {
        return CAMediaTimingFunctionName(rawValue: input)
    }
}
