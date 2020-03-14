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
     var mainContainerViewButtomConstraint = NSLayoutConstraint()
     var containerViewTopConstraint = NSLayoutConstraint()
     var imageViewTopConstraint = NSLayoutConstraint()
    
    //MARK: UI Objects
    lazy var topView:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.002074310789, green: 0.4873697162, blue: 0.7545115948, alpha: 1)
        return view
    }()
    
    lazy var cancelIcon:UIImageView = {
         let gesture = UITapGestureRecognizer(target: self, action: #selector(handleCancelView))
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        iv.image = UIImage(systemName: "xmark.circle.fill")
        iv.tintColor = #colorLiteral(red: 0.002074310789, green: 0.4873697162, blue: 0.7545115948, alpha: 1)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = iv.frame.height / 2
        iv.layer.borderWidth = 5
        iv.backgroundColor = .white
        iv.layer.borderColor = UIColor.white.cgColor
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(gesture)
        return iv
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
        button.addTarget(self, action: #selector(handleResetButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       configureMainContainerViewConstraints()
        setupContainerView()
        configurelockImageConstraints()
        configureResetLabelConstraits()
        configureInstructionLabelConstraints()
        configureResetButtonConstraints()
        configureEmailTextFieldConstraints()
        addKeyBoardHandlingObservers()
        configureTopViewConstraints()
        configureCancelIconConstraints()
    }
    
    //MARK: @objc func
    @objc func handleCancelView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleResetButtonPressed(){
        guard let email = emailTextField.text, emailTextField.text != "" else {
            self.showAlert(alertTitle: "Error", alertMessage: "Please enter a valid email address", actionTitle: "OK")
            return
        }
        
        FirebaseAuthService.manager.resetPassword(email: email) { (result) in
            switch result{
            case .failure(let error):
                self.showAlert(alertTitle: "Error", alertMessage: "There seems to be a problem resetting your password. Please try again or contact customer service. Error: \(error)", actionTitle: "OK")
            case .success(()):
                self.showAlert(alertTitle: "Success", alertMessage: "A message has been sent to your email provided. Please follow instruction to reset your password", actionTitle: "OK")
            }
        }
    }
    
    @objc func formValidation(){
        guard emailTextField.hasText else {
            resetButton.isEnabled = false
            resetButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            return}
        
        resetButton.isEnabled = true
        resetButton.backgroundColor = .blue
    }
    
    @objc func handleKeyBoardShowing(sender notification:Notification){
           guard let infoDict = notification.userInfo else {return}
           guard let keyboardFreme = infoDict[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
           guard let duration = infoDict[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
           
           self.mainContainerViewButtomConstraint.constant = -100 - (keyboardFreme.height - 150)
           self.containerViewTopConstraint.constant = 280 - (keyboardFreme.height - 150)
           
           UIView.animate(withDuration: duration) {
               self.view.layoutIfNeeded()
           }
       }
       
       @objc func handleKeyBoardHiding(sender notification:Notification){
           guard let infoDict = notification.userInfo else {return}
           guard let duration = infoDict[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
           
           self.mainContainerViewButtomConstraint.constant = -100
           self.containerViewTopConstraint.constant = 280
           
           UIView.animate(withDuration: duration) {
               self.view.layoutIfNeeded()
           }
       }
    
    //MARK: Private function
    private func addKeyBoardHandlingObservers(){
           NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardShowing(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardHiding(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
