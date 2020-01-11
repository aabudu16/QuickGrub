//
//  ForgetPasswordViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 1/11/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit
import TextFieldEffects

class ForgetPasswordViewController: UIViewController {

    //MARK: UI Objects
    lazy var topView:UIView = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleCancelView))
     let view = UIView()
        view.backgroundColor = .blue
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    lazy var emailTextField:HoshiTextField = {
        let tf = HoshiTextField(keyboardType: .emailAddress, placeholder: "Email", borderActiveColor: .blue)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        tf.delegate = self
        return tf
    }()
    
    lazy var sendButton:UIButton = {
       let button = UIButton()
        return button
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    //MARK: @objc func
    @objc func handleCancelView(){
       print("view tapped")
    }
    
    @objc func formValidation(){
        guard emailTextField.hasText else {
            sendButton.isEnabled = false
            sendButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            return}
        
        sendButton.isEnabled = true
        sendButton.backgroundColor = .blue
    }
}

//MARK: Extension
extension ForgetPasswordViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailTextField.placeholderColor = .blue
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailTextField.placeholderColor = .black
    }
}
