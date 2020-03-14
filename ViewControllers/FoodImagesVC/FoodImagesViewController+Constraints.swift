//
//  FoodImagesViewController+Constraints.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension FoodImagesViewController {
    //MARK: constraints func
    
    func addSubview() {
        view.addSubview(collectionView)
        view.addSubview(backgroundImageView)
        view.addSubview(dimView)
        instructionLabelView.addSubview(checkMarkIndicatorView)
        checkMarkIndicatorView.addSubview(checkMarkIndicator)
        dimView.addSubview(instructionLabelView)
        instructionLabelView.addSubview(instructionLabel)
        view.addSubview(activityIndicator)
        view.addSubview(continueButtom)
    }
    
    func configureCollectionviewConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: pointEstimator.relativeHeight(multiplier: 0.1754)), collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor), collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor), collectionView.heightAnchor.constraint(equalToConstant: pointEstimator.relativeHeight(multiplier: 0.6887))])
    }
    
    func configureBackgroundImageViewConstraints(){
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([backgroundImageView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor), backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor), backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor), backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func configureDimViewConstraints(){
        dimView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([dimView.topAnchor.constraint(equalTo: view.topAnchor), dimView.leadingAnchor.constraint(equalTo: view.leadingAnchor), dimView.trailingAnchor.constraint(equalTo: view.trailingAnchor), dimView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func configureCheckMarkIndicatorViewConstraints(){
        checkMarkIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([checkMarkIndicatorView.topAnchor.constraint(equalTo: instructionLabelView.topAnchor), checkMarkIndicatorView.leadingAnchor.constraint(equalTo: instructionLabelView.leadingAnchor), checkMarkIndicatorView.trailingAnchor.constraint(equalTo: instructionLabelView.trailingAnchor), checkMarkIndicatorView.bottomAnchor.constraint(equalTo: instructionLabel.topAnchor)])
    }
    
    func configureCheckMarkIndicatorConstraints(){
        checkMarkIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([checkMarkIndicator.topAnchor.constraint(equalTo: checkMarkIndicatorView.topAnchor, constant: -50), checkMarkIndicator.leadingAnchor.constraint(equalTo: checkMarkIndicatorView.leadingAnchor, constant: -50), checkMarkIndicator.trailingAnchor.constraint(equalTo: checkMarkIndicatorView.trailingAnchor, constant: 50) ,checkMarkIndicator.bottomAnchor.constraint(equalTo: checkMarkIndicatorView.bottomAnchor, constant: 50)])
    }
    
    func configureInstructionLabelViewConstraints(){
        instructionLabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([instructionLabelView.centerYAnchor.constraint(equalTo: dimView.centerYAnchor), instructionLabelView.centerXAnchor.constraint(equalTo: dimView.centerXAnchor), instructionLabelView.heightAnchor.constraint(equalToConstant: 300), instructionLabelView.widthAnchor.constraint(equalToConstant: 300)])
    }
    
    func configureInstructionLabelConstraints(){
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([instructionLabel.leadingAnchor.constraint(equalTo: instructionLabelView.leadingAnchor), instructionLabel.trailingAnchor.constraint(equalTo: instructionLabelView.trailingAnchor) , instructionLabel.bottomAnchor.constraint(equalTo: instructionLabelView.bottomAnchor), instructionLabel.heightAnchor.constraint(equalToConstant: 200)])
    }
    
    func constraintsActivityIndicatorConstraints(){
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func configureContinueButtomConstraints(){
        continueButtom.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([continueButtom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), continueButtom.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20), continueButtom.heightAnchor.constraint(equalToConstant: 50), continueButtom.widthAnchor.constraint(equalTo: continueButtom.heightAnchor)])
    }
}
