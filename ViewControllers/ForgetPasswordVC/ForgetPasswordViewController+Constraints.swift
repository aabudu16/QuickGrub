//
//  ForgetPasswordViewController+Constraints.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension ForgetPasswordViewController {
    //MARK: Private constraints
    
    func addSubviews() {
        view.addSubview(mainCotainerView)
        mainCotainerView.addSubview(containerView)
        mainCotainerView.addSubview(lockImage)
        containerView.addSubview(resetLabel)
        containerView.addSubview(resetButton)
        containerView.addSubview(emailTextField)
        view.addSubview(topView)
        view.addSubview(cancelIcon)
    }
    
    func configureMainContainerViewConstraints(){
        mainCotainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [mainCotainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  15),
             mainCotainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -15)])
        
        self.mainContainerViewButtomConstraint = mainCotainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -100)
        mainContainerViewButtomConstraint.isActive = true
        
        self.containerViewTopConstraint = mainCotainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 280)
        containerViewTopConstraint.isActive = true
    }
    
    func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [containerView.leadingAnchor.constraint(equalTo: mainCotainerView.leadingAnchor),
             containerView.trailingAnchor.constraint(equalTo: mainCotainerView.trailingAnchor), containerView.bottomAnchor.constraint(equalTo: mainCotainerView.bottomAnchor), containerView.topAnchor.constraint(equalTo: mainCotainerView.topAnchor, constant: 75)])
    }
    
    func configurelockImageConstraints() {
        lockImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [lockImage.widthAnchor.constraint(equalToConstant: 150), lockImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
             lockImage.heightAnchor
                .constraint(equalToConstant: 150)])
        imageViewTopConstraint = lockImage.topAnchor.constraint(equalTo: mainCotainerView.topAnchor)
        imageViewTopConstraint.isActive = true
    }
    
    func configureResetLabelConstraits(){
        resetLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resetLabel.topAnchor.constraint(equalTo: lockImage.bottomAnchor,constant: 3),resetLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor), resetLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor), resetLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    func configureInstructionLabelConstraints(){
        containerView.addSubview(instructionLabel)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([instructionLabel.topAnchor.constraint(equalTo: resetLabel.bottomAnchor, constant: 0),instructionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20), instructionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20), instructionLabel.heightAnchor.constraint(equalToConstant: 50) ])
    }
    
    func configureResetButtonConstraints(){
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resetButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -25), resetButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10), resetButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10), resetButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    func configureEmailTextFieldConstraints(){
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([emailTextField.bottomAnchor.constraint(equalTo: resetButton.topAnchor,constant: -60), emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                                     emailTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.72),
                                     emailTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.13)])
    }
    
    func configureTopViewConstraints(){
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topView.topAnchor.constraint(equalTo: view.topAnchor), topView.leadingAnchor.constraint(equalTo: view.leadingAnchor), topView.trailingAnchor.constraint(equalTo: view.trailingAnchor), topView.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    func configureCancelIconConstraints(){
        cancelIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([cancelIcon.centerXAnchor.constraint(equalTo: topView.centerXAnchor), cancelIcon.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -(cancelIcon.frame.height / 2)), cancelIcon.heightAnchor.constraint(equalToConstant: 70), cancelIcon.widthAnchor.constraint(equalToConstant: 70)])
    }
}
