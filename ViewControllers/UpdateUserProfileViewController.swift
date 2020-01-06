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

class UpdateUserProfileViewController: UIViewController {
    //MARK: UI Objects
    lazy var updateProfileLabel:UILabel = {
        let label = UILabel()
        label.text = "Update Profile"
        label.font =  UIFont(name: "HelveticaNeue-Bold", size: 25)
        label.textColor = .white
        return label
    }()
    
    lazy var profileImage:UIImageView = {
        let guesture = UITapGestureRecognizer(target: self, action: #selector(presentPHPhotoLibrary(sender:)))
        guesture.numberOfTapsRequired = 1
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
        image.image = UIImage(named: "bagels")
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
        button.addTarget(self, action: #selector(handleUpdateButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)
        return button
    }()
    
    lazy var camerabutton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    lazy var userNameTextField:HoshiTextField = {
        let tf = HoshiTextField(keyboardType: UIKeyboardType.namePhonePad, placeholder: "User name", borderActiveColor: UIColor.blue)
        tf.delegate = self
        return tf
    }()
    
    lazy var userEmailTextField:HoshiTextField = {
        let tf = HoshiTextField(keyboardType: UIKeyboardType.namePhonePad, placeholder: "Email", borderActiveColor: UIColor.blue)
        tf.delegate = self
        return tf
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
        configureUserEmailTextFieldConstraints()
        configureCancelButtonConstraints()
        configureUpdateButtonConstraints()
        
    }
    
    //MARK: @objc function
    
    @objc func handleDismissButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUpdateButtonPressed(){
        print("update button pressed")
    }
    
    @objc func presentPHPhotoLibrary(sender:UITapGestureRecognizer){
            print("Image view Double tapped")
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
    
    //MARK: Private function
    private func presentPhotoPickerController() {
        DispatchQueue.main.async{
            let imagePickerViewController = UIImagePickerController()
           // imagePickerViewController.delegate = self
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
        
        NSLayoutConstraint.activate([updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35), updateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),updateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),updateButton.heightAnchor.constraint(equalToConstant: 45)])
    }
    
    private func configureCamerabuttonConstraints(){
        view.addSubview(camerabutton)
        camerabutton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([camerabutton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: -(camerabutton.frame.height / 2)), camerabutton.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor), camerabutton.heightAnchor.constraint(equalToConstant:100),camerabutton.heightAnchor.constraint(equalToConstant: 100)])
    }
    
    private func configureUserNameTextFieldConstraints(){
        view.addSubview(userNameTextField)
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([userNameTextField.topAnchor.constraint(equalTo: profileImage.bottomAnchor,constant: 3),userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor) ,userNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72),
        userNameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13)])
    }
    
    private func configureUserEmailTextFieldConstraints(){
        view.addSubview(userEmailTextField)
        userEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([userEmailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 5),userEmailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor) ,userEmailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72),
        userEmailTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13)])
    }
    
    private func configureCancelButtonConstraints(){
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant:  5), cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -5), cancelButton.heightAnchor.constraint(equalToConstant: 50), cancelButton.widthAnchor.constraint(equalToConstant: 50)])
    }
}

extension UpdateUserProfileViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
