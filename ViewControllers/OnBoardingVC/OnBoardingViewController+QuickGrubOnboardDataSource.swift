//
//  OnBoardingViewController+QuickGrubOnboardDataSource.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension OnBoardingViewController : QuickGrubOnboardDataSource{
    func quickGrubOnboardBackgroundColorFor(_ quickGrubOnBoarding: QuickGrubOnBoarding, atIndex index: Int) -> UIColor? {
        switch index{
        case 0:
            return .white
        case 1:
            return .blue
        case 2:
            return .yellow
        default:
            return .white
        }
    }
    
    func quickGrubOnboardNumberOfPages(_ quickGrubOnBoarding: QuickGrubOnBoarding) -> Int {
        return 4
    }
    
    func quickGrubOnboardPageForIndex(_ quickGrubOnBoarding: QuickGrubOnBoarding, index: Int) -> QuickGrubOnBoardingPage? {
        let page = QuickGrubOnBoardingPage()
        
        return page
    }
    
    func quickGrubOnboardOverlayForPosition(_ quickGrubOnBoarding: QuickGrubOnBoarding, overlay: QuickGrubOnboardOverlay, for position: Double) {
        overlay.continueButton.isHidden = quickGrubOnBoarding.currentPage == 3 ? false : true
        overlay.continueButton.isEnabled = quickGrubOnBoarding.currentPage == 3 ? true : false
        overlay.nextLabel.isHidden = quickGrubOnBoarding.currentPage == 3 ? true : false
        overlay.prevLabel.isHidden = quickGrubOnBoarding.currentPage == 0 ? true : false
        overlay.skipButton.isHidden = quickGrubOnBoarding.currentPage == 3 ? true : false
        overlay.skipButton.isEnabled = quickGrubOnBoarding.currentPage == 3 ? false : false
    }
    
    func quickGrubOnboardViewForOverlay(_ quickGrubOnBoarding: QuickGrubOnBoarding) -> QuickGrubOnboardOverlay? {
         let overLay = QuickGrubOnboardOverlay()
        overLay.skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        
        overLay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        return overLay
    }
}

