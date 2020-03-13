//
//  ViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import SHSearchBar
import TextFieldEffects
import Photos
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //MARK: properties
    var userName:String!
    private var currentUser: Result<User, Error>!
    private var mainContainerViewButtomConstraint = NSLayoutConstraint()
    private var containerViewTopConstraint = NSLayoutConstraint()
    private var imageViewTopConstraint = NSLayoutConstraint()
    
    var image = UIImage() {
        didSet {
            self.logoImageView.image = image
            logoImageView.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    var imageURL: URL? = nil
    
    //MARK: UI Objects
    
    lazy var transparentView:UIView = {
        let tv = UIView(frame: UIScreen.main.bounds)
        tv.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        tv.isUserInteractionEnabled = false
        tv.isHidden = true
        return tv
    }()
    
    lazy var gifActivityIndicator:UIImageView = {
        let gifImage = UIImageView()
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = transparentView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(name: "loader")
        return gifImage
    }()
    
    lazy var loadingLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: "Loading Quick Grub")
        return label
    }()
    
    lazy var bottomnView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
    
    lazy var cameraImage:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "camera")
        image.alpha = 0
        image.tintColor = .gray
        return image
    }()
    
    lazy var logoImageView: UIImageView = {
        let guesture = UITapGestureRecognizer(target: self, action: #selector(presentUpdateProfileVC(sender:)))
        guesture.numberOfTapsRequired = 1
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "QG")
        iv.layer.cornerRadius = iv.layer.frame.height / 2
        iv.backgroundColor = .white
        iv.clipsToBounds = true
        iv.addGestureRecognizer(guesture)
        return iv
    }()
    
    lazy var loginLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: "Login")
        label.font = UIFont(name: "Avenir-Heavy", size: 23)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var emailTextField:HoshiTextField = {
        let tf = HoshiTextField(keyboardType: .emailAddress, placeholder: "Email", borderActiveColor: .blue)
        tf.addTarget(self, action: #selector(loginFormValidation), for: .editingChanged)
        
        tf.delegate = self
        return tf
    }()
    
    lazy var passwordTextField:HoshiTextField = {
        let tf = HoshiTextField(keyboardType: .namePhonePad, placeholder: "Password", borderActiveColor: .blue)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(loginFormValidation), for: .editingChanged)
        
        tf.delegate = self
        return tf
    }()
    
    lazy var signupEmailTextField:HoshiTextField = {
        let tf = HoshiTextField(keyboardType: .emailAddress, placeholder: "Enter email", borderActiveColor: .green)
        tf.addTarget(self, action: #selector(signupFormValidation), for: .editingChanged)
        tf.delegate = self
        return tf
    }()
    
    
    lazy var signupPasswordTextField:HoshiTextField = {
        let tf = HoshiTextField(keyboardType: .namePhonePad, placeholder: "Create password", borderActiveColor: .green)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(signupFormValidation), for: .editingChanged)
        tf.delegate = self
        return tf
    }()
    
    lazy var userNameTextField:HoshiTextField = {
        let tf = HoshiTextField(keyboardType: .namePhonePad, placeholder: "User Name", borderActiveColor: UIColor.green)
        tf.autocorrectionType = .no
        tf.addTarget(self, action: #selector(signupFormValidation), for: .editingChanged)
        tf.delegate = self
        return tf
    }()
    
    lazy var loginButton:UIButton = {
        let button = UIButton(alpha: 1, contentMode: .scaleAspectFit)
        CustomLayer.shared.createCustomlayer(layer: button.layer, cornerRadius: 25, borderWidth: 0.5)
        button.setTitle("Enter", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(handleLoginPressed), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var registerButton:UIButton = {
        let button = UIButton(alpha: 1, contentMode: .scaleAspectFit)
        CustomLayer.shared.createCustomlayer(layer: button.layer, cornerRadius: 25, borderWidth: 0.5)
        button.isEnabled = false
        button.setTitle("Register", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(handleRegisterPressed), for: .touchUpInside)
        return button
    }()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView()
        av.style = .large
        av.hidesWhenStopped = true
        return av
    }()
    
    lazy var segmentedController: UISegmentedControl = {
        let font = UIFont.systemFont(ofSize: 18)
        let items = ["Login", "Sign up"]
        let segment = UISegmentedControl(items: items)
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = .white
        segment.selectedSegmentTintColor = #colorLiteral(red: 0.1316526234, green: 0, blue: 1, alpha: 1)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        segment.addTarget(self, action: #selector(handleSegmentControlChanged(_:)), for: .valueChanged)
        return segment
    }()
    
    lazy var forgetPasswordButton: UIButton = {
        let font = UIFont.systemFont(ofSize: 14)
        let button = UIButton(type: .system)
        let atttributedTitle = NSMutableAttributedString(string: "Forgot password?  ", attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.generateColorValue(red: 17, green: 154, blue: 237, alpha: 1)])
        button.setAttributedTitle(atttributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleForgetPasswordButtonPressed), for: .touchUpInside)
        return button
        
    }()
    //MARK: LifeCycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .blue
        setLoginButton(enable: true)
        setSignupObjectViewsVisible(enable: false)
        configureAllConstrainsts()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loginButton.setTitle("Enter", for: .normal)
        activityIndicator.stopAnimating()
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    //MARK: Objc Selector functions
    
    @objc private func presentUpdateProfileVC(sender:UITapGestureRecognizer) {
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
    //MARK: Private Methods
    
    
    private func configureAllConstrainsts(){
        configureBottomViewConstraints()
        configureMainContainerViewConstraints()
        setupContainerView()
        configureLogoImageView()
        configureLoginLabel()
        configureCameraImageConstraints()
        configureEmailTextField()
        configurePasswordTextField()
        configureLoginButton()
        configureActivityIndcatorConstrainst()
        addKeyBoardHandlingObservers()
        configureSegmentedControllerConstraints()
        configureUserNameTextField()
        configureSignupEmailTextField()
        configureSignupPasswordTextField()
        configureRegisterButton()
        configureForgotButtonButton()
        configureGifAnimationConstraints()
    }
    
    private func presentPhotoPickerController() {
        DispatchQueue.main.async{
            let imagePickerViewController = UIImagePickerController()
            imagePickerViewController.delegate = self
            imagePickerViewController.sourceType = .photoLibrary
            imagePickerViewController.allowsEditing = true
            imagePickerViewController.mediaTypes = ["public.image", "public.movie"]
            self.present(imagePickerViewController, animated: true, completion: nil)
        }
    }
    
    private func handleCreateAccountResponse(with result: Result<User, Error>) {
        //    DispatchQueue.main.async { [weak self] in
        switch result {
        case .success(let user):
            FirestoreService.manager.createAppUser(user: UserProfile(from: user)) { [weak self] newResult in
                guard FirebaseAuthService.manager.currentUser != nil else {
                    print("cant create user")
                    return
                }
                
                // handles creating and updaring current user profile
                FirestoreService.manager.updateCurrentUser(userName: self?.userName, photoURL: self?.imageURL) { [weak self] (nextResult) in
                    switch nextResult {
                    case .success():
                        FirebaseAuthService.manager.updateUserFields(userName: self?.userName, photoURL: self?.imageURL) { (updateUser) in
                            
                            switch updateUser{
                            case .failure(let error):
                                self?.showAlert(alertTitle:  "Error", alertMessage:  "Problem updating your information. please try again.. Error \(error)", actionTitle: "OK")
                            case .success():
                                self?.setSceneDelegateInitialVC(with: result )
                            }
                        }
                        //stop activity indicator
                        self?.transparentView.isHidden = true
                        print(self?.userName)
                        print(self?.imageURL?.absoluteString)
                    case .failure(let error):
                        self?.showAlert(alertTitle:  "Error", alertMessage:  "It seem your image or user name was not save. Please input a valid  user name, check your image format and try again", actionTitle: "OK")
                        self?.transparentView.isHidden = true
                        print(error)
                        return
                    }
                }
                print(newResult)
                self?.view.backgroundColor = .green
            }
        case .failure(let error):
            self.showAlert(alertTitle: "Error creating user", alertMessage: "An error occured while creating new account \(error)", actionTitle: "OK")
        }
    }
    
    private func setSceneDelegateInitialVC(with result: Result<User, Error>) {
        DispatchQueue.main.async { [weak self] in
            switch result {
            case.success(let user):
                print(user)
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                    else { return }
                
                if FirebaseAuthService.manager.currentUser != nil {
                    UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                        window.rootViewController = WelcomeViewController()
                    }, completion: nil)
                    
                } else {
                    print("No current user")
                }
                
                
            case .failure(let error):
                self?.showAlert(alertTitle: "Error Creating User", alertMessage: error.localizedDescription, actionTitle: "OK")
            }
            
        }
    }
    private func handleLoginResponse(with result: Result<(), Error>) {
        switch result {
            
        case .success:
            
            configureViewWhenUserClicksLogin(enable: true)
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else {
                    //MARK: TODO - handle could not swap root view controller
                    return
            }
            
            configureViewWhenUserClicksLogin(enable: false)
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                if FirebaseAuthService.manager.currentUser != nil {
                    window.rootViewController = WelcomeViewController()
                    
                } else {
                    self.showAlert(alertTitle: "Error", alertMessage: "Account does not exist", actionTitle: "OK")
                }
            }, completion: nil)
        case .failure(let error):
            self.showAlert(alertTitle: "Invalid Entry", alertMessage: error.localizedDescription, actionTitle: "OK")
        }
    }
    
    private func setSignupObjectViewsVisible(enable:Bool){
        switch enable{
        case true:
            userNameTextField.isHidden = false
            userNameTextField.isEnabled = true
            signupEmailTextField.isHidden = false
            signupEmailTextField.isEnabled = true
            signupPasswordTextField.isHidden = false
            signupPasswordTextField.isEnabled = true
            registerButton.isHidden = false
            
        case false:
            userNameTextField.isHidden = true
            userNameTextField.isEnabled = false
            signupEmailTextField.isHidden = true
            signupEmailTextField.isEnabled = false
            signupPasswordTextField.isHidden = true
            signupPasswordTextField.isEnabled = false
            registerButton.isHidden = true
        }
    }
    
    
    private func setLoginObjectViewsVisible(enable:Bool){
        switch enable{
        case true:
            emailTextField.isHidden = false
            emailTextField.isEnabled = true
            passwordTextField.isHidden = false
            passwordTextField.isEnabled = true
            loginButton.isHidden = false
        case false:
            emailTextField.isHidden = true
            emailTextField.isEnabled = false
            passwordTextField.isHidden = true
            passwordTextField.isEnabled = false
            loginButton.isHidden = true
        }
    }
    // Enable or Disable the login button
    
    private func configureViewWhenUserClicksLogin(enable: Bool){
        switch enable{
        case true:
            setLoginButton(enable: true)
            loginButton.setTitle("Login", for: .normal)
            activityIndicator.stopAnimating()
            transparentView.isHidden = true
        case false:
            setLoginButton(enable: false)
            loginButton.setTitle("", for: .normal)
            loginButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            activityIndicator.startAnimating()
            transparentView.isHidden = false
        }
    }
    private func setLoginButton(enable:Bool){
        switch enable {
        case true:
            loginButton.alpha = 1
            loginButton.isEnabled = true
        case false:
            loginButton.alpha = 0.8
            loginButton.isEnabled = false
        }
    }
    private func addKeyBoardHandlingObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardShowing(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardHiding(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
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
extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            //MARK: TODO - handle couldn't get image :(
            return
        }
        self.image = image
        
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            //MARK: TODO - gracefully fail out without interrupting UX
            return
        }
        
        FirebaseStorageService.manager.storeUserInputImage(image: imageData, completion: { [weak self] (result) in
            switch result{
            case .success(let url):
                self?.imageURL = url
            case .failure(let error):
                self?.logoImageView.layer.borderColor = UIColor.red.cgColor
                
                print(error)
            }
        })
        dismiss(animated: true, completion: nil)
    }
}
