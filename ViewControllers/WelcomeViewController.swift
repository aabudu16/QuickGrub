//
//  WelcomeViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {
    
    //MARK: UI Objects
    
    let filterMenuHeight:CGFloat = 420
    
    lazy var filterMenuView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.filterMenuHeight))
        view.backgroundColor = .white
        return view
    }()
    
    lazy var deemView:UIView = {
        let deemView = UIView()
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(dismissDeemView))
        deemView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        deemView.alpha = 0
        deemView.addGestureRecognizer(tapGuesture)
        return deemView
    }()
    
    lazy var welcomeLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: "Welcome")
        return label
    }()
    
    lazy var selectionLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: "Make a selection")
        return label
    }()
    lazy var menuButton:UIButton = {
        let button = UIButton()
        let filterImage = UIImage(named: "menu")
        button.setImage(filterImage, for: .normal)
        button.addTarget(self, action:  #selector(handleMenuButtonPressed), for: .touchUpInside)
        button.contentMode = .scaleToFill
        return  button
    }()
    
    lazy var logoutButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logoutIcon2"), for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    lazy var profileImage:UIImageView = {
        let guesture = UITapGestureRecognizer(target: self, action: #selector(imageViewDoubleTapped(sender:)))
        guesture.numberOfTapsRequired = 1
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
        image.image = UIImage(named: "profileImage")
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(guesture)
        return image
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
        setupView()
    }
    
    //MARK: Objc Selector functions
    
    @objc func handleMenuButtonPressed(){
        if let window = UIApplication.shared.keyWindow{
            window.addSubview(deemView)
            window.addSubview(filterMenuView)
            deemView.frame = window.frame
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.deemView.alpha = 1
                self.filterMenuView.frame = CGRect(x: 0, y: (self.view.frame.height - self.filterMenuHeight) + 20, width: self.view.frame.width, height: self.filterMenuHeight)
            }, completion: nil)
        }
    }
    
    @objc func dismissDeemView(){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.deemView.alpha = 0
            self.filterMenuView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.filterMenuHeight)
        }, completion: { (_) in
            self.deemView.removeFromSuperview()
        })
    }
    
    @objc func handleCategoryPressed(){
        let categoryVC = CategoryViewController()
        let categoryVCWithNav =  UINavigationController(rootViewController: categoryVC)
        categoryVCWithNav.modalPresentationStyle = .fullScreen
        present(categoryVCWithNav, animated: true)
    }
    
    @objc func imageViewDoubleTapped(sender:UITapGestureRecognizer){
        print("Image view tapped")
    }
    
    @objc func handleRandomPressed(){
        print("randomButton")
    }
    
    @objc func handleLogout(){
        do{
            try Auth.auth().signOut()
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true, completion: nil)
        }catch let error{
            showAlert(with: "Error", and: "Problem logining out \(error)")
        }
    }
    //MARK: Private Methods
    
    
    //MARK: Constriaints Function
    
    private func setupView(){
        view.backgroundColor = .orange
        configureWelcomeLabelConstraints()
        configureSelectionLabelConstraints()
        configureCategoryButtonConstraints()
        configureRandomButtonnConstraints()
        configureLogoutButtonConstraints()
        configureProfileImageConstraint()
        navigationController?.isNavigationBarHidden = true
    }
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
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
    
    private func configureLogoutButtonConstraints(){
        view.addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5), menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10), menuButton.heightAnchor.constraint(equalToConstant: 30), menuButton.widthAnchor.constraint(equalToConstant: 30)])
    }
    
    private func configureProfileImageConstraint(){
        view.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10), profileImage.heightAnchor.constraint(equalToConstant: 50), profileImage.widthAnchor.constraint(equalToConstant: 50)])
    }
}
