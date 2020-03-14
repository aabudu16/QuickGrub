//
//  LoginViewController+Objc.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit
import Photos

extension LoginViewController {
    //MARK: Objc Selector functions
    
    @objc func presentUpdateProfileVC(sender:UITapGestureRecognizer) {
        print("Image view Double tapped")
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined, .denied, .restricted:
            PHPhotoLibrary.requestAuthorization({[weak self] status in
                switch status {
                case .authorized:
                    self?.presentPhotoPickerController()
                case .denied:
                    self?.showAlert(alertTitle: "Caution", alertMessage: "A profile image is required to create an account. Go to your settings to grant access in order to proceed", actionTitle: "OK")
                default:
                     self?.presentPhotoPickerController()
                }
            })
        default:
            presentPhotoPickerController()
        }
    }
    
    @objc func handleForgetPasswordButtonPressed(){
       let forgetVC = ForgetPasswordViewController()
        present(forgetVC, animated: true, completion: nil)
    }
    
    @objc func handleRegisterPressed(){
        guard  signupEmailTextField.hasText, signupPasswordTextField.hasText else {
            return}
        
        guard userNameTextField.text != "", logoImageView.image != UIImage(named: "imagePlaceholder") else {
            self.showAlert(alertTitle: "Error", alertMessage: "Please use a valid image and user name", actionTitle: "OK")
            return
        }
        guard let email = signupEmailTextField.text, let password = signupPasswordTextField.text else {
            self.showAlert(alertTitle: "Error", alertMessage: "Please fill out all fields.", actionTitle: "OK")
            return
        }
        
        guard let userName = userNameTextField.text, imageURL != nil else {
            self.showAlert(alertTitle: "Error", alertMessage: "Please use a valid image and user name", actionTitle: "OK")
            return
        }
        
        self.userName = userName
        self.transparentView.isHidden = false
        FirebaseAuthService.manager.createNewUser(email: email.lowercased(), password: password) { [weak self] (result) in
            self?.currentUser = result
            self?.handleCreateAccountResponse(with: result)
        }
        
    }
    
    @objc func handleLoginPressed(){
        
        guard  emailTextField.hasText, passwordTextField.hasText else {
            return}
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            self.showAlert(alertTitle:  "Error", alertMessage: "Please fill out all fields.", actionTitle: "OK")
            return
        }
        
        guard email.isValidEmail else {
            self.showAlert(alertTitle:  "Error", alertMessage:  "Please enter a valid email", actionTitle: "OK")
            return
        }
        
        guard password.isValidPassword else {
             self.showAlert(alertTitle:  "Error", alertMessage: "Please enter a valid password. Passwords must have at least 8 characters.", actionTitle: "OK")
            return
        }
        
        FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
            self.handleLoginResponse(with: result)
        }
    }
    
    @objc func signupFormValidation(){
        guard signupEmailTextField.hasText, signupPasswordTextField.hasText, userNameTextField.hasText else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            return
        }
        
        registerButton.isEnabled = true
        registerButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
    
    @objc func loginFormValidation(){
        guard emailTextField.hasText, passwordTextField.hasText else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            return}
        
        loginButton.isEnabled = true
        loginButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
    
    @objc func handleKeyBoardShowing(sender notification:Notification){
        guard let infoDict = notification.userInfo else {return}
        guard let keyboardFreme = infoDict[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        guard let duration = infoDict[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        
        self.mainContainerViewButtomConstraint.constant = -100 - (keyboardFreme.height - 50)
        self.containerViewTopConstraint.constant = 325 - (keyboardFreme.height - 50)
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleKeyBoardHiding(sender notification:Notification){
        guard let infoDict = notification.userInfo else {return}
        guard let duration = infoDict[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        
        self.mainContainerViewButtomConstraint.constant = -100
        self.containerViewTopConstraint.constant = 325
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    //Write code to switch on segment
    @objc func handleSegmentControlChanged(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            segmentedController.selectedSegmentTintColor = #colorLiteral(red: 0.1294232607, green: 0, blue: 0.9888512492, alpha: 1)
            UIView.transition(with: mainCotainerView, duration: 1.2, options: .transitionFlipFromLeft, animations: {
                self.setLoginObjectViewsVisible(enable: true)
                self.setSignupObjectViewsVisible(enable: false)
                self.loginLabel.text = "Login"
                self.logoImageView.image = UIImage(named: "QG")
                self.cameraImage.alpha = 0
            }, completion: { (_) in
                self.logoImageView.isUserInteractionEnabled = false
                
            })
            
            
        case 1:
            segmentedController.selectedSegmentTintColor = UIColor.green
            UIView.transition(with: mainCotainerView, duration: 1.2, options: .transitionFlipFromRight, animations: {
                self.setLoginObjectViewsVisible(enable: false)
                self.setSignupObjectViewsVisible(enable: true)
                self.loginLabel.text = "Signup"
                self.logoImageView.image = nil
                self.cameraImage.alpha = 1
            }, completion: { (_) in
                self.logoImageView.isUserInteractionEnabled = true
            })
        default:
            break
        }
    }
}
