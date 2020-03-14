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
