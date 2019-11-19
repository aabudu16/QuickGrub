//
//  WelcomeViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    //MARK: UI Objects
    lazy var welcomeLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: "Welcome")
        return label
    }()
    
    lazy var selectionLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: "Make a selection")
        return label
    }()
    
    
    lazy var categoryButton:UIButton = {
        let button = UIButton(image: UIImage(named: "category")!, color: UIColor.white.cgColor)
        button.addTarget(self, action: #selector(handleCategoryPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var randomButton:UIButton = {
        let button = UIButton(image: UIImage(named: "category")!, color: UIColor.white.cgColor)
        button.addTarget(self, action: #selector(handleRandomPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        configureWelcomeLabelConstraints()
        configureSelectionLabelConstraints()
        configureCategoryButtonConstraints()
        configureRandomButtonnConstraints()
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
      //MARK: Objc Selector functions
    
    @objc func handleCategoryPressed(){
        let categoryVC = CategoryViewController()
        let categoryVCWithNav =  UINavigationController(rootViewController: categoryVC)
        categoryVCWithNav.modalPresentationStyle = .fullScreen
               present(categoryVCWithNav, animated: true)
    }
    
    @objc func handleRandomPressed(){
        print("randomButton")
    }
    
    @objc func handleLogout(){
        navigationController?.popViewController(animated: true)
    }
     //MARK: Private Methods
    
    
     //MARK: Constriaints Function
    private func configureWelcomeLabelConstraints(){
        view.addSubview(welcomeLabel)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([welcomeLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10), welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),welcomeLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func configureSelectionLabelConstraints(){
        view.addSubview(selectionLabel)
        
        selectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([selectionLabel.topAnchor.constraint(equalTo: self.welcomeLabel.bottomAnchor, constant: 10), selectionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),selectionLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func configureCategoryButtonConstraints(){
        view.addSubview(categoryButton)
        
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([categoryButton.topAnchor.constraint(equalTo:self.selectionLabel.bottomAnchor, constant: 10), categoryButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20), categoryButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20), categoryButton.heightAnchor.constraint(equalToConstant: 250)])
    }
    
    private func configureRandomButtonnConstraints(){
        view.addSubview(randomButton)
        
        randomButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([randomButton.topAnchor.constraint(equalTo:self.categoryButton.bottomAnchor, constant: 100), randomButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20), randomButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20), randomButton.heightAnchor.constraint(equalTo: categoryButton.heightAnchor)])
    }
}
