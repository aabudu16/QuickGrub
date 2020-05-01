//
//  WelcomeViewController+Constraints.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 5/1/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension WelcomeViewController {
    func addSubviews(){
        view.addSubview(backgroundImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(selectionLabel)
        view.addSubview(categoryButton)
        categoryButton.addSubview(categoryLabel)
        view.addSubview(favoriteButton)
        favoriteButton.addSubview(savedLabel)
        view.addSubview(profileImage)
    }
    
    //MARK: Constriaints Function
    func backgroundImageViewConstraints(){
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor), backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor), backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor), backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func configureWelcomeLabelConstraints(){
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([welcomeLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10), welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),welcomeLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    func configureSelectionLabelConstraints(){
        selectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([selectionLabel.topAnchor.constraint(equalTo: self.welcomeLabel.bottomAnchor, constant: 10), selectionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),selectionLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    func configureCategoryButtonConstraints(){
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([categoryButton.topAnchor.constraint(equalTo:self.selectionLabel.bottomAnchor, constant: 10), categoryButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20), categoryButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20), categoryButton.heightAnchor.constraint(equalToConstant: 250)])
    }
    
    
    func configureCategoryLabelConstraints(){
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([categoryLabel.topAnchor.constraint(equalTo: categoryButton.topAnchor), categoryLabel.leadingAnchor.constraint(equalTo: categoryButton.leadingAnchor), categoryLabel.trailingAnchor.constraint(equalTo: categoryButton.trailingAnchor), categoryLabel.bottomAnchor.constraint(equalTo: categoryButton.bottomAnchor)])
    }
    
    func configureRandomButtonnConstraints(){
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([favoriteButton.topAnchor.constraint(equalTo:self.categoryButton.bottomAnchor, constant: 100), favoriteButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20), favoriteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20), favoriteButton.heightAnchor.constraint(equalTo: categoryButton.heightAnchor)])
    }
    
    
    func savedLabelConstriants() {
        savedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([savedLabel.topAnchor.constraint(equalTo: favoriteButton.topAnchor), savedLabel.leadingAnchor.constraint(equalTo: favoriteButton.leadingAnchor), savedLabel.trailingAnchor.constraint(equalTo: favoriteButton.trailingAnchor), savedLabel.bottomAnchor.constraint(equalTo: favoriteButton.bottomAnchor)])
    }
    
    func configureProfileImageConstraint(){
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10), profileImage.heightAnchor.constraint(equalToConstant: 50), profileImage.widthAnchor.constraint(equalToConstant: 50)])
    }
}
