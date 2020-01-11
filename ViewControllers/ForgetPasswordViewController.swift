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
        //tf.addTarget(self, action: #selector(loginFormValidation), for: .editingChanged)
        
        tf.delegate = self
        return tf
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
