//
//  FoldingCell+Animations.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 5/1/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension FoldingCell {
    // MARK: Animations
    
    dynamic func animationDuration(_ itemIndex: NSInteger, type: AnimationType) -> TimeInterval {
        return type == .close ? durationsForCollapsedState[itemIndex] : durationsForExpandedState[itemIndex]
    }

    func durationSequence(_ type: AnimationType) -> [TimeInterval] {
        var durations = [TimeInterval]()
        for i in 0 ..< itemCount - 1 {
            let duration = animationDuration(i, type: type)
            durations.append(TimeInterval(duration / 2.0))
            durations.append(TimeInterval(duration / 2.0))
        }
        return durations
    }
    
    func removeImageItemsFromAnimationView() {
        guard let animationView = self.animationView else {
            return
        }
        animationView.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func openAnimation(_ completion: (() -> Void)?) {
        isUnfolded = true
        removeImageItemsFromAnimationView()
        addImageItemsToAnimationView()
        
        animationView?.alpha = 1
        containerView.alpha = 0
        
        let durations = durationSequence(.open)
        
        var delay: TimeInterval = 0
        var timing = convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeIn)
        var from: CGFloat = 0.0
        var to: CGFloat = -CGFloat.pi / 2
        var hidden = true
        configureAnimationItems(.open)
        
        guard let animationItemViews = self.animationItemViews else {
            return
        }
        
        for index in 0 ..< animationItemViews.count {
            let animatedView = animationItemViews[index]
            
            animatedView.foldingAnimation(timing, from: from, to: to, duration: durations[index], delay: delay, hidden: hidden)
            
            from = from == 0.0 ? CGFloat.pi / 2 : 0.0
            to = to == 0.0 ? -CGFloat.pi / 2 : 0.0
            timing = timing == convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeIn) ? convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeOut) : convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeIn)
            hidden = !hidden
            delay += durations[index]
        }
        
        let firstItemView = animationView?.subviews.filter { $0.tag == 0 }.first
        
        firstItemView?.layer.masksToBounds = true
        DispatchQueue.main.asyncAfter(deadline: .now() + durations[0], execute: {
            firstItemView?.layer.cornerRadius = 0
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.animationView?.alpha = 0
            self.containerView.alpha = 1
            completion?()
        }
    }
    
    func closeAnimation(_ completion: (() -> Void)?) {
        isUnfolded = false
        removeImageItemsFromAnimationView()
        addImageItemsToAnimationView()
        
        guard let animationItemViews = self.animationItemViews else {
            fatalError()
        }
        
        animationView?.alpha = 1
        containerView.alpha = 0
        
        let durations: [TimeInterval] = durationSequence(.close).reversed()
        
        var delay: TimeInterval = 0
        var timing = convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeIn)
        var from: CGFloat = 0.0
        var to: CGFloat = CGFloat.pi / 2
        var hidden = true
        configureAnimationItems(.close)
        
        if durations.count < animationItemViews.count {
            fatalError("wrong override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval")
        }
        for index in 0 ..< animationItemViews.count {
            let animatedView = animationItemViews.reversed()[index]
            
            animatedView.foldingAnimation(timing, from: from, to: to, duration: durations[index], delay: delay, hidden: hidden)
            
            to = to == 0.0 ? CGFloat.pi / 2 : 0.0
            from = from == 0.0 ? -CGFloat.pi / 2 : 0.0
            timing = timing == convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeIn) ? convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeOut) : convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeIn)
            hidden = !hidden
            delay += durations[index]
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            self.animationView?.alpha = 0
            completion?()
        })
        
        let firstItemView = animationView?.subviews.filter { $0.tag == 0 }.first
        firstItemView?.layer.cornerRadius = 0
        firstItemView?.layer.masksToBounds = true
        if let durationFirst = durations.first {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay - durationFirst * 2, execute: {
                firstItemView?.layer.cornerRadius = self.foregroundView.layer.cornerRadius
                firstItemView?.setNeedsDisplay()
                firstItemView?.setNeedsLayout()
            })
        }
    }
}
