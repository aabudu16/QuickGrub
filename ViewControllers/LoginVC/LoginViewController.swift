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
     var currentUser: Result<User, Error>!
     var mainContainerViewButtomConstraint = NSLayoutConstraint()
     var containerViewTopConstraint = NSLayoutConstraint()
     var imageViewTopConstraint = NSLayoutConstraint()
    
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
    
    //MARK: function
     func presentPhotoPickerController() {
        DispatchQueue.main.async{
            let imagePickerViewController = UIImagePickerController()
            imagePickerViewController.delegate = self
            imagePickerViewController.sourceType = .photoLibrary
            imagePickerViewController.allowsEditing = true
            imagePickerViewController.mediaTypes = ["public.image", "public.movie"]
            self.present(imagePickerViewController, animated: true, completion: nil)
        }
    }
    
     func handleCreateAccountResponse(with result: Result<User, Error>) {
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

    func handleLoginResponse(with result: Result<(), Error>) {
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
    
    func setLoginObjectViewsVisible(enable:Bool){
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
    
     func setSignupObjectViewsVisible(enable:Bool){
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
