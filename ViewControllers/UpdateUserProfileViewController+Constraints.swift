//
//  UpdateUserProfileViewController+Constraints.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension UpdateUserProfileViewController {
    //MARK:-- Constraints
     func configureTopViewConstraints(){
           view.addSubview(topView)
           topView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),topView.leadingAnchor.constraint(equalTo: view.leadingAnchor), topView.trailingAnchor.constraint(equalTo: view.trailingAnchor), topView.heightAnchor.constraint(equalToConstant: 140)])
       }
       
        func configureProfileImageConstraints(){
           view.addSubview(profileImage)
           profileImage.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor), profileImage.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -(profileImage.frame.height / 2)), profileImage.heightAnchor.constraint(equalToConstant: 120), profileImage.widthAnchor.constraint(equalToConstant: 120)])
       }
       
        func configureUpdateProfileLabelConstraints(){
           topView.addSubview(updateProfileLabel)
           updateProfileLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([updateProfileLabel.topAnchor.constraint(equalTo: topView.topAnchor,constant: 3),updateProfileLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10), updateProfileLabel.heightAnchor.constraint(equalToConstant: 50), updateProfileLabel.widthAnchor.constraint(equalToConstant: 200)])
       }
       
        func configureUpdateButtonConstraints(){
           view.addSubview(updateButton)
           updateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([updateButton.topAnchor.constraint(equalToSystemSpacingBelow: userEmailTextField.bottomAnchor, multiplier: 10), updateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),updateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),updateButton.heightAnchor.constraint(equalToConstant: 45)])
       }
       
        func configureCamerabuttonConstraints(){
           view.addSubview(camerabutton)
           camerabutton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([camerabutton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: -(camerabutton.frame.height / 2)), camerabutton.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor), camerabutton.heightAnchor.constraint(equalToConstant:100),camerabutton.heightAnchor.constraint(equalToConstant: 100)])
       }
       
        func configureUserNameTextFieldConstraints(){
           view.addSubview(userNameTextField)
           userNameTextField.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([userNameTextField.topAnchor.constraint(equalTo: camerabutton.bottomAnchor,constant: 3),userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor) ,userNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72),
                                        userNameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13)])
       }
       
        func configureUpdateUserNameIconConstraints(){
           userNameTextField.addSubview(updateUserNameIcon)
           updateUserNameIcon.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([updateUserNameIcon.bottomAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: -10), updateUserNameIcon.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor, constant: -2), updateUserNameIcon.heightAnchor.constraint(equalToConstant: 20), updateUserNameIcon.widthAnchor.constraint(equalToConstant: 20)])
       }
       
        func configureUserEmailTextFieldConstraints(){
           view.addSubview(userEmailTextField)
           userEmailTextField.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([userEmailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 5),userEmailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor) ,userEmailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72),
                                        userEmailTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13)])
       }
       
        func configureUpdateEmailIconConstraints(){
              userEmailTextField.addSubview(updateEmailIcon)
              updateEmailIcon.translatesAutoresizingMaskIntoConstraints = false
              NSLayoutConstraint.activate([updateEmailIcon.bottomAnchor.constraint(equalTo: userEmailTextField.bottomAnchor, constant: -5), updateEmailIcon.trailingAnchor.constraint(equalTo: userEmailTextField.trailingAnchor, constant: -2), updateEmailIcon.heightAnchor.constraint(equalToConstant: 20), updateEmailIcon.widthAnchor.constraint(equalToConstant: 20)])
          }
       
        func configureCancelButtonConstraints(){
           topView.addSubview(cancelButton)
           cancelButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([cancelButton.topAnchor.constraint(equalTo: topView.topAnchor, constant:  5), cancelButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant:  -5), cancelButton.heightAnchor.constraint(equalToConstant: 50), cancelButton.widthAnchor.constraint(equalToConstant: 50)])
       }
       
        func configureActivityIndicatorConstraint(){
           view.addSubview(activityIndicator)
           activityIndicator.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([activityIndicator.topAnchor.constraint(equalTo: view.topAnchor), activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor), activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor), activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
       }
       
        func configureLogoutButtonConstraints(){
           view.addSubview(logoutButton)
           logoutButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5), logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80), logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.09),
           logoutButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.045)])
       }
       
        func  configureLogoutLabelConstraints(){
           view.addSubview(logoutLabel)
           logoutLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([logoutLabel.topAnchor.constraint(equalTo: logoutButton.topAnchor), logoutLabel.leadingAnchor.constraint(equalTo: logoutButton.trailingAnchor, constant: 2), logoutLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor), logoutLabel.heightAnchor.constraint(equalTo: logoutButton.heightAnchor)])
       }
}
