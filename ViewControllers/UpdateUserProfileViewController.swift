//
//  UpdateUserProfileViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 1/5/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

class UpdateUserProfileViewController: UIViewController {
    //MARK: UI Objects
    lazy var updateProfilrLate:UILabel = {
        let label = UILabel()
        label.text = "Update Profile"
        return label
    }()
    
    lazy var profileImage:UIImageView = {
        let guesture = UITapGestureRecognizer(target: self, action: #selector(imageViewDoubleTapped(sender:)))
        guesture.numberOfTapsRequired = 1
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
        image.image = UIImage(named: "bagels")
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.addGestureRecognizer(guesture)
        return image
    }()
    
    lazy var topView:UIView = {
       let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    lazy var rightBarButton:UIBarButtonItem = {
        let settingsImage = UIImage(systemName: "gear")
        let button = UIBarButtonItem(image: settingsImage, style: .plain, target: self, action: #selector(handleSettingsButtonPressed(_:)))
          
           button.tintColor = .black
           return button
       }()
    
    lazy var updateButton:UIButton = {
        let button = UIButton()
        button.setTitle("Update", for: .normal)
        button.titleLabel?.font =  UIFont(name: "HelveticaNeue-Bold", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(handleUpdateButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureTopViewConstraints()
        configureProfileImageConstraints()
    }
    
    //MARK: @objc function
    @objc func handleUpdateButtonPressed(){
        print("update button pressed")
    }
    
    @objc func imageViewDoubleTapped(sender:UITapGestureRecognizer){
        print("Image view tapped")
    }
    
    @objc func handleSettingsButtonPressed(_ sender:UIBarButtonItem){
        print("Image view tapped")
    }
    private func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func configureTopViewConstraints(){
        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),topView.leadingAnchor.constraint(equalTo: view.leadingAnchor), topView.trailingAnchor.constraint(equalTo: view.trailingAnchor), topView.heightAnchor.constraint(equalToConstant: 140)])
    }
    
    private func configureProfileImageConstraints(){
        view.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor), profileImage.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -(profileImage.frame.height / 2)), profileImage.heightAnchor.constraint(equalToConstant: 100), profileImage.widthAnchor.constraint(equalToConstant: 100)])
    }
    
}
