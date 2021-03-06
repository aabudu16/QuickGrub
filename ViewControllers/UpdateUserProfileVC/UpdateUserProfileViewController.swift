//
//  UpdateUserProfileViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 1/5/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit
import TextFieldEffects
import Photos
import Kingfisher

class UpdateUserProfileViewController: UIViewController {
    //MARK: UI Objects
    
    var imageURL: URL?
    lazy var updateProfileLabel:UILabel = {
        let label = UILabel()
        label.text = "Update Profile"
        label.font =  UIFont(name: "HelveticaNeue-Bold", size: 25)
        label.textColor = .white
        return label
    }()
    
    lazy var profileImage:UIImageView = {
        let guesture = UITapGestureRecognizer(target: self, action: #selector(presentPHPhotoLibrary(sender:)))
        guesture.numberOfTapsRequired = 2
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
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
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
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
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(handleUpdateButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)
        return button
    }()
    
    lazy var camerabutton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.tintColor = .gray
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(presentPHPhotoLibrary(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var userNameTextField:HoshiTextField = {
        let tf = HoshiTextField(keyboardType: UIKeyboardType.namePhonePad, placeholder: "User name", borderActiveColor: UIColor.blue)
        tf.delegate = self
        return tf
    }()
    
    lazy var updateUserNameIcon:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "pencil")
        image.tintColor = #colorLiteral(red: 0.01854561083, green: 0.8099911809, blue: 0.6765680909, alpha: 1)
        return image
    }()
    
    lazy var userEmailTextField:HoshiTextField = {
        let tf = HoshiTextField(keyboardType: UIKeyboardType.namePhonePad, placeholder: "Email", borderActiveColor: UIColor.blue)
        tf.delegate = self
        return tf
    }()
    
    lazy var updateEmailIcon:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "pencil")
        image.tintColor = #colorLiteral(red: 0.01854561083, green: 0.8099911809, blue: 0.6765680909, alpha: 1)
        return image
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView()
        av.style = .large
        av.hidesWhenStopped = true
        return av
    }()
    
    lazy var logoutButton:UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(named: "logout"), for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    lazy var logoutLabel:UILabel = {
        let guesture = UITapGestureRecognizer(target: self, action: #selector(handleLogout))
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.text = "Logout"
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(guesture)
        return label
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        configureTopViewConstraints()
        configureProfileImageConstraints()
        configureUpdateProfileLabelConstraints()
        configureCamerabuttonConstraints()
        configureUserNameTextFieldConstraints()
        configureUpdateUserNameIconConstraints()
        configureUserEmailTextFieldConstraints()
        configureUpdateEmailIconConstraints()
        configureCancelButtonConstraints()
        configureUpdateButtonConstraints()
        configureActivityIndicatorConstraint()
        setupProfileImage()
        setupUserNameTextField()
        setupUserEmailTextField()
        setImageURLString()
        configureLogoutButtonConstraints()
        configureLogoutLabelConstraints()
    }
    
    //MARK: @objc function
    
    @objc func handleDismissButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUpdateButtonPressed(){
        guard userEmailTextField.hasText, userEmailTextField.text != "" else{
            self.showAlert(alertTitle: "Caution", alertMessage: "Enter A valid Email", actionTitle: "OK")
            return
        }
        
        guard userNameTextField.hasText, userNameTextField.text != "" else{
            self.showAlert(alertTitle: "Caution", alertMessage: "Enter A valid user name", actionTitle: "OK")
            return
        }
        
        guard imageURL != nil else {
            self.showAlert(alertTitle: "Caution", alertMessage: "Enter A valid Image", actionTitle: "OK")
            return}
        
        guard let email = userEmailTextField.text else {return}
        guard let userName = userNameTextField.text else {return}
        guard let imageURL = imageURL else {return}
        activityIndicator.startAnimating()
        updateCurrentUser(userName: userName, email: email, imageURL: imageURL)
    }
    
    @objc func presentPHPhotoLibrary(sender:UITapGestureRecognizer){
        //MARK: TODO - action sheet with multiple media options
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined, .denied, .restricted:
            PHPhotoLibrary.requestAuthorization({[weak self] status in
                switch status {
                case .authorized:
                    self?.presentPhotoPickerController()
                case .denied:
                    //MARK: TODO - set up more intuitive UI interaction
                    print("Denied photo library permissions")
                default:
                    //MARK: TODO - set up more intuitive UI interaction
                    print("No usable status")
                }
            })
        default:
            presentPhotoPickerController()
        }
        
    }
    
    @objc func handleSettingsButtonPressed(_ sender:UIBarButtonItem){
        print("Image view tapped")
    }
    
    @objc func handleLogout(){
        FirebaseAuthService.manager.logoutUser { (result) in
            switch result{
            case .failure(let error):
                self.showAlert(alertTitle: "Error", alertMessage: "Seem to have problem logining out \(error)", actionTitle: "OK")
            case .success(()):
                let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: Private function
    
    private func updateCurrentUser(userName:String, email:String, imageURL:URL ) {
        FirestoreService.manager.updateCurrentUser(userName: userName,photoURL: imageURL ,email: email) { (result) in
            switch result{
            case .failure(let error):
                self.showAlert(alertTitle: "Error", alertMessage: "seems to be having a problem updating your pofile \(error)", actionTitle: "OK")
                self.activityIndicator.stopAnimating()
            case .success(()):
                FirebaseAuthService.manager.updateUserFields(userName: userName, photoURL: imageURL) { (result) in
                    switch result{
                    case .success(()):
                        self.updateFireBaseEmail(email: email)
                    case .failure(let error):
                        print(error)
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
    
    func showDismissAlert (alertTitle: String?, alertMessage: String, actionTitle: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let alertAction1 = UIAlertAction(title: actionTitle, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(alertAction1)
        present(alert, animated: true, completion: nil)
    }
    
    private func setImageURLString(){
        guard let currentUser = FirebaseAuthService.manager.currentUser else {return}
        if let url = currentUser.photoURL{
            imageURL = url
        }
    }
    
    private func updateFireBaseEmail(email:String){
        FirebaseAuthService.manager.updateUserEmail(email: email) { (result) in
            switch result{
            case .success(()):
                self.showDismissAlert(alertTitle: "Success", alertMessage: "Your profile was updated", actionTitle: "OK")
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                self.showAlert(alertTitle: "Error", alertMessage: "seems to be having a problem updating your pofile \(error)", actionTitle: "OK")
                self.activityIndicator.stopAnimating()
            }
        }
    }
    private func setupProfileImage(){
        let placeholderImage =  UIImage(systemName: "photo")?.withTintColor(.black)
        guard let currentUser = FirebaseAuthService.manager.currentUser else {return}
        profileImage.kf.setImage(with: currentUser.photoURL, placeholder: placeholderImage)
    }
    
    private func setupUserNameTextField(){
        guard let currentUser = FirebaseAuthService.manager.currentUser else {return}
        userNameTextField.text = "\(currentUser.displayName ?? "")"
    }
    
    private func setupUserEmailTextField(){
        guard let currentUser = FirebaseAuthService.manager.currentUser else {return}
        userEmailTextField.text = "\(currentUser.email ?? "")"
    }
    
    private func presentPhotoPickerController() {
        updateButton.isEnabled = false
        updateButton.backgroundColor = .gray
        DispatchQueue.main.async{
            let imagePickerViewController = UIImagePickerController()
            imagePickerViewController.delegate = self
            imagePickerViewController.sourceType = .photoLibrary
            imagePickerViewController.allowsEditing = true
            imagePickerViewController.mediaTypes = ["public.image", "public.movie"]
            self.present(imagePickerViewController, animated: true, completion: nil)
        }
    }
    private func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
}

//MARK:-- Extensions
extension UpdateUserProfileViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
