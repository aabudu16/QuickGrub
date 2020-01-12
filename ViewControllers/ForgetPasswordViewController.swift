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
    
    //MARK: properties
    private var containerViewButtomConstraint = NSLayoutConstraint()
    private var containerViewTopConstraint = NSLayoutConstraint()
    private var imageViewTopConstraint = NSLayoutConstraint()
    
    //MARK: UI Objects
    lazy var topView:UIView = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleCancelView))
        let view = UIView()
        view.backgroundColor = .blue
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    lazy var mainCotainerView:UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.alpha = 1
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        CustomLayer.shared.createCustomlayer(layer: view.layer, cornerRadius: 25)
        view.layer.borderWidth = 0
        return view
    }()
    
    lazy var lockImage:UIImageView = {
        let image = UIImageView()
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 2
        
        image.image = UIImage(named: "lockIcon")
        return image
    }()
    
    lazy var emailTextField:HoshiTextField = {
        let tf = HoshiTextField(keyboardType: .emailAddress, placeholder: "Enter email", borderActiveColor: .blue)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        tf.delegate = self
        return tf
    }()
    
    lazy var resetLabel:UILabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 2
        
        label.font = UIFont(name: "VAvenir-Light", size: 18)
        label.text = "Reset your password?"
        return label
    }()
    
    lazy var instructionLabel:UILabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 2
        
        label.font = UIFont(name: "Avenir-Black", size: 18)
        label.numberOfLines = 0
        label.text = "We just need your registered email to send you password reset"
        return label
    }()
    
    lazy var resetButton:UIButton = {
        let button = UIButton()
        CustomLayer.shared.createCustomlayer(layer: button.layer, cornerRadius: 25)
        button.setTitle("RESET PASSWORD", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        button.showsTouchWhenHighlighted = true
        button.isEnabled = false
        return button
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureMainContainerViewConstraints()
        
    }
    
    //MARK: @objc func
    @objc func handleCancelView(){
        print("view tapped")
    }
    
    @objc func formValidation(){
        guard emailTextField.hasText else {
            resetButton.isEnabled = false
            resetButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            return}
        
        resetButton.isEnabled = true
        resetButton.backgroundColor = .blue
    }
    
    //MARK: Private constraints
    private func configureMainContainerViewConstraints(){
        view.addSubview(mainCotainerView)
        mainCotainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [mainCotainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  15),
             mainCotainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -15)])
        
        self.containerViewButtomConstraint = mainCotainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -100)
        containerViewButtomConstraint.isActive = true
        
        self.containerViewTopConstraint = mainCotainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 325)
        containerViewTopConstraint.isActive = true
    }
    
    private func setupContainerView() {
        mainCotainerView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [containerView.leadingAnchor.constraint(equalTo: mainCotainerView.leadingAnchor),
             containerView.trailingAnchor.constraint(equalTo: mainCotainerView.trailingAnchor), containerView.bottomAnchor.constraint(equalTo: mainCotainerView.bottomAnchor), containerView.topAnchor.constraint(equalTo: mainCotainerView.topAnchor, constant: 75)])
    }
}

//MARK: Extension
extension  ForgetPasswordViewController : UITextFieldDelegate{
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
