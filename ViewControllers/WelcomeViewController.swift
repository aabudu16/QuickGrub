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
    //MARK:-- Properties
    lazy var backgroundImageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        return image
    }()
    
    lazy var welcomeLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: "Welcome")
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = .white
        return label
    }()
    
    lazy var selectionLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: "Make a selection")
        label.textColor = .white
        return label
    }()

    lazy var profileImage:UIImageView = {
        let guesture = UITapGestureRecognizer(target: self, action: #selector(presentUpdateProfileVC(sender:)))
        guesture.numberOfTapsRequired = 1
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
        image.image = UIImage(named: "profileImage")
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFill
        image.addGestureRecognizer(guesture)
        return image
    }()
    
    lazy var categoryButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.alpha = 0.7
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleCategoryPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var categoryLabel:UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont(name: "AcademyEngravedLetPlain", size: 55)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 0.5
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        return label
    }()
    
    lazy var favoriteButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleFavoriteButtonPressed), for: .touchUpInside)
        button.backgroundColor = .black
        button.alpha = 0.7
        button.layer.cornerRadius = 20
        button.isUserInteractionEnabled = true
        return button
    }()
    
    lazy var savedLabel:UILabel = {
        let label = UILabel()
        label.text = "Saved"
        label.font = UIFont(name: "AcademyEngravedLetPlain", size: 55)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 0.5
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        return label
    }()
    //MARK:-- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setupProfileImage()
        setupWelcomeLabel()
        hideNavigationBar()
    }
    
    //MARK:-- Objc functions
    @objc func handleCategoryPressed(){
        
        let categoryVC = CategoryViewController()
        let categoryVCWithNav =  UINavigationController(rootViewController: categoryVC)
        categoryVCWithNav.modalPresentationStyle = .fullScreen
        present(categoryVCWithNav, animated: true)
    }
    
    @objc func presentUpdateProfileVC(sender:UITapGestureRecognizer){
        let updateProfileVC = UpdateUserProfileViewController()
        updateProfileVC.modalPresentationStyle = .fullScreen
        present(updateProfileVC, animated: true, completion: nil)
    }
    
    @objc func handleFavoriteButtonPressed(){
        let favoriteVC = FavoriteViewController()
        navigationController?.pushViewController(favoriteVC, animated: true)
    }

    //MARK: Private Methods
    
    private func setupView(){
        backgroundImageViewConstraints()
        configureWelcomeLabelConstraints()
        configureSelectionLabelConstraints()
        configureCategoryButtonConstraints()
        configureCategoryLabelConstraints()
        configureRandomButtonnConstraints()
        configureProfileImageConstraint()
        savedLabelConstriants()
    }
    
    private func hideNavigationBar(){
        navigationController?.isNavigationBarHidden = true
    }
    private func setupProfileImage(){
        let placeholderImage =  UIImage(systemName: "photo")?.withTintColor(.black)
        guard let currentUser = FirebaseAuthService.manager.currentUser else {return}
        profileImage.kf.setImage(with: currentUser.photoURL, placeholder: placeholderImage)
    }
    
    private func setupWelcomeLabel(){
        guard let currentUser = FirebaseAuthService.manager.currentUser else {return}
        welcomeLabel.text = "Welcome \(currentUser.displayName?.capitalized ?? "")"
    }
    private func addToStackViewButtons(array : [UIButton]) -> UIStackView {
        let sv = UIStackView(arrangedSubviews: array)
        sv.distribution = .fillEqually
        sv.spacing = 3
        sv.axis = .horizontal
        return sv
    }
    
    private func createUILableView(name:String, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.textAlignment = textAlignment
        label.text = name
        
        return label
    }
    
    private func createHairLineView()-> UIView{
        let hairLine = UIView()
        hairLine.backgroundColor = .lightGray
        return hairLine
    }
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
