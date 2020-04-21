//
//  LoginViewController+Constraints.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension LoginViewController {
    //MARK: Constriaints Function
       
        func configureBottomViewConstraints(){
           view.addSubview(bottomnView)
           
           bottomnView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [bottomnView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                bottomnView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bottomnView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomnView.heightAnchor.constraint(equalToConstant: CGFloat(view.layer.frame.height/2))])
       }
       
        func setupContainerView() {
           mainCotainerView.addSubview(containerView)
           containerView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [containerView.leadingAnchor.constraint(equalTo: mainCotainerView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: mainCotainerView.trailingAnchor), containerView.bottomAnchor.constraint(equalTo: mainCotainerView.bottomAnchor), containerView.topAnchor.constraint(equalTo: mainCotainerView.topAnchor, constant: 75)
                   
           ])
       }
       
        func configureLogoImageView() {
           mainCotainerView.addSubview(logoImageView)
           logoImageView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [logoImageView.widthAnchor.constraint(equalToConstant: 150), logoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                logoImageView.heightAnchor
                   .constraint(equalToConstant: 150)])
           imageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: mainCotainerView.topAnchor)
           imageViewTopConstraint.isActive = true
       }
       
        func configureCameraImageConstraints(){
           logoImageView.addSubview(cameraImage)
           cameraImage.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([cameraImage.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor), cameraImage.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor), cameraImage.heightAnchor.constraint(equalToConstant: 30), cameraImage.widthAnchor.constraint(equalToConstant: 30)])
       }
       
        func configureLoginLabel(){
           containerView.addSubview(loginLabel)
           loginLabel.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([loginLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),loginLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 2), loginLabel.trailingAnchor.constraint(equalTo: logoImageView.leadingAnchor), loginLabel.heightAnchor.constraint(equalToConstant: 40)])
       }
       
       
        func configureEmailTextField() {
           containerView.addSubview(emailTextField)
           emailTextField.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
                emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                emailTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.72),
                emailTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.13)])
       }
       
        func configurePasswordTextField() {
           containerView.addSubview(passwordTextField)
           passwordTextField.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
                passwordTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
                passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor)])
       }
       
       
        func configureLoginButton() {
           containerView.addSubview(loginButton)
           loginButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
                loginButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier: 0.80),
                loginButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor, multiplier: 0.95),
                loginButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)])
       }
       
        func configureActivityIndcatorConstrainst(){
           loginButton.addSubview(activityIndicator)
           activityIndicator.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [activityIndicator.topAnchor.constraint(equalTo: loginButton.topAnchor),
                activityIndicator.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
                activityIndicator.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
                activityIndicator.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor)])
       }
       
        func configureSegmentedControllerConstraints(){
           containerView.addSubview(segmentedController)
           segmentedController.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([segmentedController.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -35), segmentedController.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 15),segmentedController.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -15), segmentedController.heightAnchor.constraint(equalToConstant: 30)])
       }
       
        func configureUserNameTextField() {
           containerView.addSubview(userNameTextField)
           userNameTextField.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
                userNameTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                userNameTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.72),
                userNameTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.13)])
       }
       
        func configureSignupEmailTextField() {
           containerView.addSubview(signupEmailTextField)
           signupEmailTextField.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [signupEmailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 1),
                signupEmailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                signupEmailTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.72),
                signupEmailTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.13)])
       }
       
        func configureSignupPasswordTextField() {
           containerView.addSubview(signupPasswordTextField)
           signupPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [signupPasswordTextField.topAnchor.constraint(equalTo: signupEmailTextField.bottomAnchor, constant: 1),
                signupPasswordTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                signupPasswordTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.72),
                signupPasswordTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.13)])
       }
       
        func configureRegisterButton() {
           containerView.addSubview(registerButton)
           registerButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [registerButton.topAnchor.constraint(equalTo: signupPasswordTextField.bottomAnchor, constant: 10),
                registerButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor),
                registerButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
                registerButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)])
       }
       
        func configureForgotButtonButton() {
           containerView.addSubview(forgetPasswordButton)
           forgetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate(
               [forgetPasswordButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                forgetPasswordButton.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: -2),
                forgetPasswordButton.heightAnchor.constraint(equalToConstant: 50)])
       }
       
        func configureMainContainerViewConstraints(){
           view.addSubview(mainCotainerView)
           mainCotainerView.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate(
               [mainCotainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  15),
                mainCotainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -15)
           ])
           
           self.mainContainerViewButtomConstraint = mainCotainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -100)
           mainContainerViewButtomConstraint.isActive = true
           
           self.containerViewTopConstraint = mainCotainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 325)
           containerViewTopConstraint.isActive = true
       }
       
        func configureGifAnimationConstraints(){
           mainCotainerView.addSubview(transparentView)
           transparentView.addSubview(gifActivityIndicator)
           transparentView.addSubview(loadingLabel)
           
           transparentView.translatesAutoresizingMaskIntoConstraints = false
           gifActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
           loadingLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([transparentView.centerXAnchor.constraint(equalTo: mainCotainerView.centerXAnchor),transparentView.centerYAnchor.constraint(equalTo: mainCotainerView.centerYAnchor), transparentView.widthAnchor.constraint(equalToConstant: 220), transparentView.heightAnchor.constraint(equalToConstant: 100)])
           NSLayoutConstraint.activate([gifActivityIndicator.topAnchor.constraint(equalTo: transparentView.topAnchor), gifActivityIndicator.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor),gifActivityIndicator.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor), gifActivityIndicator.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor)])
           NSLayoutConstraint.activate([loadingLabel.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor, constant: 3),loadingLabel.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor), loadingLabel.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor), loadingLabel.heightAnchor.constraint(equalToConstant: 30)])
       }
    
    func backgroundImageConstraints(){
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([backgroundImage.topAnchor.constraint(equalTo: view.topAnchor), backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor), backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor), backgroundImage.bottomAnchor.constraint(equalTo: containerView.topAnchor)])
    }
}
