//
//  FoldingCell+Constraints.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 5/1/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension FoldingCell {
    //MARK: Constraints
    func configureForegroundViewConstraints(){
        self.addSubview(foregroundView)
        foregroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([ foregroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8), foregroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8), foregroundView.heightAnchor.constraint(equalToConstant:170)])
        
        foregroundViewTop = foregroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        foregroundViewTop.isActive = true
        
    }
    
    func configureContainerViewConstraints(){
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8), containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8), containerView.heightAnchor.constraint(equalToConstant:CGFloat(120 * itemCount))])
        
        containerViewTop = containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 97)
        containerViewTop.isActive = true
    }
    
     func configureResturantImageConstraint(){
        self.foregroundView.addSubview(foodImageView)
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([foodImageView.bottomAnchor.constraint(equalTo: self.foregroundView.bottomAnchor, constant:  -30), foodImageView.leadingAnchor.constraint(equalTo: self.foregroundView.leadingAnchor), foodImageView.trailingAnchor.constraint(equalTo: self.foregroundView.trailingAnchor), foodImageView.topAnchor.constraint(equalTo: foregroundView.topAnchor)])
    }
    
     func configureResturantNameLabelConstraints(){
        self.foregroundView.addSubview(resturantNameLabel)
        resturantNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resturantNameLabel.bottomAnchor.constraint(equalTo: self.foregroundView.bottomAnchor), resturantNameLabel.leadingAnchor.constraint(equalTo: self.foregroundView.leadingAnchor, constant: 5), resturantNameLabel.trailingAnchor.constraint(equalTo: self.foregroundView.trailingAnchor, constant: -100), resturantNameLabel.topAnchor.constraint(equalTo: self.foodImageView.bottomAnchor)])
    }
    
     func configureDistanceLabelConstraints(){
        foregroundView.addSubview(distanceLabel)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([distanceLabel.bottomAnchor.constraint(equalTo: self.foregroundView.bottomAnchor), distanceLabel.trailingAnchor.constraint(equalTo: self.foregroundView.trailingAnchor, constant: -2), distanceLabel.leadingAnchor.constraint(equalTo: resturantNameLabel.trailingAnchor), distanceLabel.topAnchor.constraint(equalTo: self.foodImageView.bottomAnchor)])
    }
    
     func configureImageScrollViewConstraints(){
        containerView.addSubview(imageScrollView)
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageScrollView.topAnchor.constraint(equalTo: containerView.topAnchor),imageScrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),imageScrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),imageScrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -260)])
    }
    
     func configurePageControlConstraints(){
        containerView.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([pageControl.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: -5), pageControl.centerXAnchor.constraint(equalTo: imageScrollView.centerXAnchor), pageControl.heightAnchor.constraint(equalToConstant: 10), pageControl.widthAnchor.constraint(equalToConstant: 30)])
    }
    
     func configureResturantNameConstraints(){
        containerView.addSubview(resturantName)
        resturantName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resturantName.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 3), resturantName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 3), resturantName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -3), resturantName.heightAnchor.constraint(equalToConstant: 50)])
    }
    
     func configureAddressTextViewConstraints(){
        containerView.addSubview(addressTextView)
        addressTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([addressTextView.topAnchor.constraint(equalTo: resturantName.bottomAnchor),addressTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 3),addressTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -100), addressTextView.heightAnchor.constraint(equalToConstant: 90)])
    }
    
     func configureResturantPhoneNumberConstraints(){
        containerView.addSubview(resturantPhoneNumber)
        resturantPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resturantPhoneNumber.topAnchor.constraint(equalTo: addressTextView.bottomAnchor,constant: 3),resturantPhoneNumber.leadingAnchor.constraint(equalTo: addressTextView.leadingAnchor),resturantPhoneNumber.trailingAnchor.constraint(equalTo: addressTextView.trailingAnchor), resturantPhoneNumber.bottomAnchor.constraint(equalTo: mapView.topAnchor, constant: -5)])
    }
    
     func configureOpenOrCloseLabelConstraints(){
        containerView.addSubview(openOrCloseLabel)
        openOrCloseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([openOrCloseLabel.topAnchor.constraint(equalTo: resturantName.bottomAnchor), openOrCloseLabel.trailingAnchor.constraint(equalTo: resturantName.trailingAnchor), openOrCloseLabel.leadingAnchor.constraint(equalTo: addressTextView.trailingAnchor, constant: 3), openOrCloseLabel.heightAnchor.constraint(equalTo: resturantName.heightAnchor)])
    }
    
     func configureMoreDetailButtonConstraints(){
        containerView.addSubview(moreDetailButton)
        moreDetailButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([moreDetailButton.topAnchor.constraint(equalTo: openOrCloseLabel.bottomAnchor,constant: 5), moreDetailButton.trailingAnchor.constraint(equalTo: openOrCloseLabel.trailingAnchor), moreDetailButton.leadingAnchor.constraint(equalTo: openOrCloseLabel.leadingAnchor), moreDetailButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
     func configureMapViewConstraints(){
        containerView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([mapView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),mapView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),mapView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor), mapView.heightAnchor.constraint(equalToConstant: 90)])
    }
    
     func configureNavigateButtomConstraints(){
        mapView.addSubview(navigateButtom)
        navigateButtom.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([navigateButtom.topAnchor.constraint(equalTo: mapView.topAnchor,constant: 20), navigateButtom.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10), navigateButtom.heightAnchor.constraint(equalToConstant: 40), navigateButtom.widthAnchor.constraint(equalTo: navigateButtom.heightAnchor)])
    }
    
     func configureHeartImageConstraints(){
        containerView.addSubview(heartImage)
        heartImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([heartImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5), heartImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5), heartImage.heightAnchor.constraint(equalToConstant: 30), heartImage.widthAnchor.constraint(equalTo: heartImage.heightAnchor)])
    }
}
