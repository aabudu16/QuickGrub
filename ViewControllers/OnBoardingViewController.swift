//
//  OnBoardingViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 2/19/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {
//MARK:-- Objects
    
    var pageCount = 0
    
    lazy var onBoardingScrollView: QuickGrubOnBoarding = {
        let scrollView = QuickGrubOnBoarding()
        scrollView.backgroundColor = .blue
        scrollView.delegate = self
        scrollView.dataSource = self
        return scrollView
    }()
    
    
    //MARK:-- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(onBoardingScrollView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       configureScrollViewConstraints()
    }
    
    //MARK:-- objc func
    @objc func handleSkip() {
           onBoardingScrollView.goToPage(index: 3, animated: true)
       }
    
    @objc func handleContinue(sender: UIButton) {
        let mainVC = LoginViewController()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true, completion: nil)
      }
    
   //MARK: -- private func
    
    private func configureScrollViewConstraints(){
        onBoardingScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([onBoardingScrollView.topAnchor.constraint(equalTo: view.topAnchor), onBoardingScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor), onBoardingScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor) ,onBoardingScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}

extension OnBoardingViewController : QuickGrubOnboardDelegate {}

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
