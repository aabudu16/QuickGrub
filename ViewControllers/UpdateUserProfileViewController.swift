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
        button.layer.borderColor = UIColor.black.cgColor
       button.layer.borderWidth = 2
        
        button.tintColor = .black
        button.setImage(UIImage(named: "logout"), for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    lazy var logoutLabel:UILabel = {
        let guesture = UITapGestureRecognizer(target: self, action: #selector(handleLogout))
        let label = UILabel()
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 2
        
        label.text = "logout"
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(guesture)
        return label
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
    
    private func configureTopViewConstraints(){
        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),topView.leadingAnchor.constraint(equalTo: view.leadingAnchor), topView.trailingAnchor.constraint(equalTo: view.trailingAnchor), topView.heightAnchor.constraint(equalToConstant: 140)])
    }
    
    private func configureProfileImageConstraints(){
        view.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor), profileImage.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -(profileImage.frame.height / 2)), profileImage.heightAnchor.constraint(equalToConstant: 120), profileImage.widthAnchor.constraint(equalToConstant: 120)])
    }
    
    private func configureUpdateProfileLabelConstraints(){
        topView.addSubview(updateProfileLabel)
        updateProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([updateProfileLabel.topAnchor.constraint(equalTo: topView.topAnchor,constant: 3),updateProfileLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10), updateProfileLabel.heightAnchor.constraint(equalToConstant: 50), updateProfileLabel.widthAnchor.constraint(equalToConstant: 200)])
    }
    
    private func configureUpdateButtonConstraints(){
        view.addSubview(updateButton)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([updateButton.topAnchor.constraint(equalToSystemSpacingBelow: userEmailTextField.bottomAnchor, multiplier: 10), updateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),updateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),updateButton.heightAnchor.constraint(equalToConstant: 45)])
    }
    
    private func configureCamerabuttonConstraints(){
        view.addSubview(camerabutton)
        camerabutton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([camerabutton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: -(camerabutton.frame.height / 2)), camerabutton.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor), camerabutton.heightAnchor.constraint(equalToConstant:100),camerabutton.heightAnchor.constraint(equalToConstant: 100)])
    }
    
    private func configureUserNameTextFieldConstraints(){
        view.addSubview(userNameTextField)
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([userNameTextField.topAnchor.constraint(equalTo: camerabutton.bottomAnchor,constant: 3),userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor) ,userNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72),
                                     userNameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13)])
    }
    
    private func configureUpdateUserNameIconConstraints(){
        userNameTextField.addSubview(updateUserNameIcon)
        updateUserNameIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([updateUserNameIcon.bottomAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: -10), updateUserNameIcon.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor, constant: -2), updateUserNameIcon.heightAnchor.constraint(equalToConstant: 20), updateUserNameIcon.widthAnchor.constraint(equalToConstant: 20)])
    }
    
    private func configureUserEmailTextFieldConstraints(){
        view.addSubview(userEmailTextField)
        userEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([userEmailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 5),userEmailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor) ,userEmailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72),
                                     userEmailTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13)])
    }
    
    private func configureUpdateEmailIconConstraints(){
           userEmailTextField.addSubview(updateEmailIcon)
           updateEmailIcon.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([updateEmailIcon.bottomAnchor.constraint(equalTo: userEmailTextField.bottomAnchor, constant: -5), updateEmailIcon.trailingAnchor.constraint(equalTo: userEmailTextField.trailingAnchor, constant: -2), updateEmailIcon.heightAnchor.constraint(equalToConstant: 20), updateEmailIcon.widthAnchor.constraint(equalToConstant: 20)])
       }
    
    private func configureCancelButtonConstraints(){
        topView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([cancelButton.topAnchor.constraint(equalTo: topView.topAnchor, constant:  5), cancelButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant:  -5), cancelButton.heightAnchor.constraint(equalToConstant: 50), cancelButton.widthAnchor.constraint(equalToConstant: 50)])
    }
    
    private func configureActivityIndicatorConstraint(){
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([activityIndicator.topAnchor.constraint(equalTo: view.topAnchor), activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor), activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor), activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func configureLogoutButtonConstraints(){
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5), logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100), logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.09),
        logoutButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.045)])
    }
    
    private func  configureLogoutLabelConstraints(){
        view.addSubview(logoutLabel)
        logoutLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([logoutLabel.topAnchor.constraint(equalTo: logoutButton.topAnchor), logoutLabel.leadingAnchor.constraint(equalTo: logoutButton.trailingAnchor), logoutLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor), logoutLabel.heightAnchor.constraint(equalTo: logoutButton.heightAnchor)])
    }
    
}

//MARK:-- Extensions
extension UpdateUserProfileViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UpdateUserProfileViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            self.showAlert(alertTitle: "Error", alertMessage: "Cant edit image", actionTitle: "OK")
            return
        }
        profileImage.image = image
        
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            return
        }
        
                FirebaseStorageService.manager.storeUserInputImage(image: imageData, completion: { [weak self] (result) in
                    switch result{
                    case .success(let url):
                            (self?.imageURL = url)!
                            self?.updateButton.isEnabled = true
                            self?.updateButton.backgroundColor = .blue
                    case .failure(let error):
                        self?.showAlert(alertTitle: "Error", alertMessage: "Ran into issues saving your image to the database, please try again \(error)", actionTitle: "OK")
                    }
                })
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        updateButton.isEnabled = true
        updateButton.backgroundColor = .blue
        picker.dismiss(animated: true, completion: nil)
    }
}
