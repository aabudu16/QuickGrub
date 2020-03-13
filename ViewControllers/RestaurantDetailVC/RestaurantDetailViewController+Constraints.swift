//
//  RestaurantDetailViewController+Constraints.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension RestaurantDetailViewController {
    //MARK: - constraints functions
    
    func addSubviews() {
        view.addSubview(imageScrollView)
        view.addSubview(pageControl)
        view.addSubview(logoView)
        logoView.addSubview(logoLabel)
        view.addSubview(badgeImageView)
        view.addSubview(restaurantName)
        view.addSubview(addressTextView)
        view.addSubview(restaurantPhoneNumber)
        view.addSubview(businessMenuButton)
        view.addSubview(starRatings)
        view.addSubview(reviewCountLabel)
        view.addSubview(containerView)
        containerView.addSubview(aboutButton)
        containerView.addSubview(reviewButton)
        view.addSubview(hoursOfOperationTextView)
        view.addSubview(navigateButtom)
    }
    
     func configureImageScrollViewConstraints(){
    imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageScrollView.topAnchor.constraint(equalTo: view.topAnchor),imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),imageScrollView.heightAnchor.constraint(equalToConstant: 300)])
    }
    
     func configurePageControlConstraints(){
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([pageControl.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: -5), pageControl.centerXAnchor.constraint(equalTo: imageScrollView.centerXAnchor), pageControl.heightAnchor.constraint(equalToConstant: 10), pageControl.widthAnchor.constraint(equalToConstant: 30)])
    }
    
     func configureLogoViewConstraints(){
        logoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([logoView.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: (logoView.layer.frame.height / 2)), logoView.trailingAnchor.constraint(equalTo: imageScrollView.trailingAnchor, constant: -10), logoView.heightAnchor.constraint(equalToConstant: 60), logoView.widthAnchor.constraint(equalToConstant: 90)])
    }
    
     func configureLogoLabelConstraints(){
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([logoLabel.topAnchor.constraint(equalTo: logoView.topAnchor, constant: 2),logoLabel.leadingAnchor.constraint(equalTo: logoView.leadingAnchor, constant: 10),logoLabel.trailingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: -2),logoLabel.bottomAnchor.constraint(equalTo: logoView.bottomAnchor)])
    }
    
     func configureBadgeImageViewConstraints(){
        badgeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([badgeImageView.topAnchor.constraint(equalTo: logoView.topAnchor,constant: -20), badgeImageView.leadingAnchor.constraint(equalTo: logoView.leadingAnchor, constant: -20), badgeImageView.heightAnchor.constraint(equalToConstant: 45), badgeImageView.widthAnchor.constraint(equalTo: badgeImageView.heightAnchor)])
        
    }
    
     func configureResturantNameConstraints(){
        restaurantName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([restaurantName.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant:  5), restaurantName.leadingAnchor.constraint(equalTo: imageScrollView.leadingAnchor, constant: 5), restaurantName.heightAnchor.constraint(equalToConstant: 50), restaurantName.trailingAnchor.constraint(equalTo: logoView.leadingAnchor, constant: -35)])
    }
    
     func configureAddressTextViewConstraints(){
        addressTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([addressTextView.topAnchor.constraint(equalTo: restaurantName.bottomAnchor), addressTextView.leadingAnchor.constraint(equalTo: imageScrollView.leadingAnchor, constant: 5), addressTextView.heightAnchor.constraint(equalToConstant: 78), addressTextView.trailingAnchor.constraint(equalTo: restaurantName.trailingAnchor)])
    }
    
     func configureRestaurantPhoneNumberConstraints(){
        restaurantPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([restaurantPhoneNumber.topAnchor.constraint(equalTo: addressTextView.bottomAnchor,constant: 0), restaurantPhoneNumber.leadingAnchor.constraint(equalTo: addressTextView.leadingAnchor), restaurantPhoneNumber.heightAnchor.constraint(equalToConstant: 40), restaurantPhoneNumber.widthAnchor.constraint(equalTo: addressTextView.widthAnchor)])
    }
    
     func configureFoodMenuButtonConstraints(){
        businessMenuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([businessMenuButton.topAnchor.constraint(equalTo: logoView.bottomAnchor,constant: 25), businessMenuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5), businessMenuButton.heightAnchor.constraint(equalToConstant: 80), businessMenuButton.widthAnchor.constraint(equalToConstant: 70)])
    }
    
     func configureStarRatingsLabelConstraints(){
        starRatings.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([starRatings.topAnchor.constraint(equalTo: restaurantPhoneNumber.bottomAnchor,constant: 0), starRatings.leadingAnchor.constraint(equalTo: restaurantPhoneNumber.leadingAnchor), starRatings.heightAnchor.constraint(equalToConstant: 30), starRatings.widthAnchor.constraint(equalToConstant: 100)])
    }
    
     func configureRatingsCountConstraints(){
        reviewCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([reviewCountLabel.topAnchor.constraint(equalTo: starRatings.topAnchor), reviewCountLabel.leadingAnchor.constraint(equalTo: starRatings.trailingAnchor,constant: 3), reviewCountLabel.trailingAnchor.constraint(equalTo: addressTextView.trailingAnchor), reviewCountLabel.heightAnchor.constraint(equalTo: starRatings.heightAnchor)])
    }
    
     func configureContainerViewConstraints(){
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([containerView.topAnchor.constraint(equalTo: starRatings.bottomAnchor), containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10), containerView.heightAnchor.constraint(equalToConstant: 45)])
    }
    
     func configureAboutButtonConstraints(){
        aboutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([aboutButton.topAnchor.constraint(equalTo: containerView.topAnchor), aboutButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor), aboutButton.widthAnchor.constraint(equalTo: starRatings.widthAnchor), aboutButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)])
    }
    
     func configureReviewButtonConstraints(){
        reviewButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([reviewButton.topAnchor.constraint(equalTo: containerView.topAnchor), reviewButton.leadingAnchor.constraint(equalTo: reviewCountLabel.leadingAnchor), reviewButton.heightAnchor.constraint(equalTo: aboutButton.heightAnchor), reviewButton.widthAnchor.constraint(equalTo: aboutButton.widthAnchor)])
    }
    
     func configureHoursOfOperationTextViewConstraints(){
        hoursOfOperationTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([hoursOfOperationTextView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 2), hoursOfOperationTextView.leadingAnchor.constraint(equalTo: addressTextView.leadingAnchor), hoursOfOperationTextView.trailingAnchor.constraint(equalTo: reviewButton.trailingAnchor, constant: 30), hoursOfOperationTextView.heightAnchor.constraint(equalToConstant: 200)])
    }
    
     func configureNavigateButtomConstraints(){
        navigateButtom.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([navigateButtom.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -30), navigateButtom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10), navigateButtom.heightAnchor.constraint(equalToConstant: 40), navigateButtom.widthAnchor.constraint(equalToConstant: 120)])
    }
}
