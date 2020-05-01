//
//  CategoryViewController+Constraints.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 5/1/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension CategoryViewController {
    
    func addSubviews(){
        view.addSubview(containerView)
        view.addSubview(searchBar)
        view.addSubview(categoryCollectionView)
        view.addSubview(continueButton)
        view.addSubview(countLabel)
        view.addSubview(searchIcon)
    }
    
    //MARK: Constriaints Function
    func configureContainerViewConstriant(){
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),containerView.heightAnchor.constraint(equalToConstant: containerHeight)])
        
        containerViewTopConstraints = containerView.topAnchor.constraint(equalTo: self.view.bottomAnchor)
        newContainerViewTopConstraints = containerView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(containerHeight) + 20)
        NSLayoutConstraint.activate([containerViewTopConstraints!])
        NSLayoutConstraint.deactivate([newContainerViewTopConstraints!])
        
    }
    
    func configureSearchBarConstaints(){
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), searchBar.heightAnchor.constraint(equalToConstant: 45)])
        
        searchBarTopConstraints = searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -(searchBar.frame.height))
        newSearchBarTopConstraints = searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0)
        NSLayoutConstraint.activate([searchBarTopConstraints!])
        NSLayoutConstraint.deactivate([newSearchBarTopConstraints!])
    }
    
    func configureCollectionViewConstraint(){
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([categoryCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor), categoryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), categoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), categoryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    
    func configureContinueButton(){
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([continueButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0), continueButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10), continueButton.heightAnchor.constraint(equalToConstant: 45), continueButton.widthAnchor.constraint(equalToConstant: 45)])
    }
    
    func configureSearchIconConstraints(){
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([searchIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10), searchIcon.heightAnchor.constraint(equalToConstant: 45), searchIcon.widthAnchor.constraint(equalToConstant: 45)])
        searchIconBottomConstraints = searchIcon.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -80)
        NSLayoutConstraint.activate([searchIconBottomConstraints!])
    }
    
    func configureCountLabelConstraints(){
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([countLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5), countLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10), countLabel.heightAnchor.constraint(equalToConstant: 50), countLabel.widthAnchor.constraint(equalToConstant: 50)])
    }
}
