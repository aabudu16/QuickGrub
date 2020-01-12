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
    private var mainContainerViewButtomConstraint = NSLayoutConstraint()
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
        view.backgroundColor = .clear
        view.alpha = 1
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        CustomLayer.shared.createCustomlayer(layer: view.layer, cornerRadius: 25, borderWidth: 0)
        return view
    }()
    
    lazy var lockImage:UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = iv.layer.frame.height / 2
        iv.backgroundColor = .white
        iv.clipsToBounds = true
        iv.image = UIImage(named: "lockIcon")
        return iv
    }()
    
    lazy var emailTextField:HoshiTextField = {
        let tf = HoshiTextField(keyboardType: .emailAddress, placeholder: "Enter email", borderActiveColor: .blue)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        tf.delegate = self
        return tf
    }()
    
    lazy var resetLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Black", size: 25)
        label.text = "Forgot password?"
        return label
    }()
    
    lazy var instructionLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Light", size: 15)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.text = "We just need your registered email to send you password reset"
        return label
    }()
    
    lazy var resetButton:UIButton = {
        let button = UIButton()
        CustomLayer.shared.createCustomlayer(layer: button.layer, cornerRadius: 25, borderWidth: 0.5)
        button.setTitle("RESET PASSWORD", for: .normal)
        button.backgroundColor = .blue
        button.showsTouchWhenHighlighted = true
        button.isEnabled = false
        return button
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureMainContainerViewConstraints()
        setupContainerView()
        configurelockImageConstraints()
        configureResetLabelConstraits()
        configureInstructionLabelConstraints()
        configureResetButtonConstraints()
        configureEmailTextFieldConstraints()
        
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
        
        self.containerViewTopConstraint = mainCotainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 280)
        containerViewTopConstraint.isActive = true
    }
    
    private func setupContainerView() {
        mainCotainerView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [containerView.leadingAnchor.constraint(equalTo: mainCotainerView.leadingAnchor),
             containerView.trailingAnchor.constraint(equalTo: mainCotainerView.trailingAnchor), containerView.bottomAnchor.constraint(equalTo: mainCotainerView.bottomAnchor), containerView.topAnchor.constraint(equalTo: mainCotainerView.topAnchor, constant: 75)])
    }
    
    private func configurelockImageConstraints() {
           mainCotainerView.addSubview(lockImage)
           lockImage.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [lockImage.widthAnchor.constraint(equalToConstant: 150), lockImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                lockImage.heightAnchor
                   .constraint(equalToConstant: 150)])
           imageViewTopConstraint = lockImage.topAnchor.constraint(equalTo: mainCotainerView.topAnchor)
           imageViewTopConstraint.isActive = true
       }
    
    private func configureResetLabelConstraits(){
        containerView.addSubview(resetLabel)
        resetLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resetLabel.topAnchor.constraint(equalTo: lockImage.bottomAnchor,constant: 3),resetLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor), resetLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor), resetLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func configureInstructionLabelConstraints(){
        containerView.addSubview(instructionLabel)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([instructionLabel.topAnchor.constraint(equalTo: resetLabel.bottomAnchor, constant: 0),instructionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20), instructionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20), instructionLabel.heightAnchor.constraint(equalToConstant: 50) ])
    }
    
    private func configureResetButtonConstraints(){
        containerView.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resetButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -25), resetButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10), resetButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10), resetButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func configureEmailTextFieldConstraints(){
        containerView.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([emailTextField.bottomAnchor.constraint(equalTo: resetButton.topAnchor,constant: -60), emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        emailTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.72),
        emailTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.13)])
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
