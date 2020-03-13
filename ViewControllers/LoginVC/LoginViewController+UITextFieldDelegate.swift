//
//  LoginViewController+UITextFieldDelegate.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

//MARK: Extension
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailTextField.placeholderColor = .blue
        passwordTextField.placeholderColor = .blue
        signupEmailTextField.placeholderColor = .green
        signupPasswordTextField.placeholderColor = .green
        userNameTextField.placeholderColor = .green
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailTextField.placeholderColor = .black
        passwordTextField.placeholderColor = .black
        signupEmailTextField.placeholderColor = .black
        signupPasswordTextField.placeholderColor = .black
        userNameTextField.placeholderColor = .black
    }
}
