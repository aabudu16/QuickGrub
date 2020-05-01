//
//  WelcomeViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {
    
//    var filterMenuViewTopConstraints:NSLayoutConstraint?
//    var newfilterMenuViewTopConstraints:NSLayoutConstraint?
//    let CDYelpBusinessSortType:Array = ["best match", "rating", "review count", "distance"]
//    let isOpenArray = ["Open", "Close", "Both"]
//    var pickerViewPick:CDYelpBusinessSortType?
//    var priceTiers:[CDYelpPriceTier]?
//    var filterParameter:FilterModel?
//    var openNow:Bool?
    
    //MARK: UI Objects
//    let filterMenuHeight:CGFloat = 400
//
//    var distanceLabel:UILabel!
//    var limitLabel:UILabel!
//    var buttonArray = [UIButton]()
//    var stackView:UIStackView!
//    lazy var filterMenuView:UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        return view
//    }()
//
//    lazy var filterLabel:UILabel = {
//        let label = UILabel()
//        label.text = "Filter"
//        label.textAlignment = .left
//        label.font = UIFont(name: "HelveticaNeue-Bold", size: 28)
//        return label
//    }()
//
//    lazy var pickerView:UIPickerView = {
//        let picker = UIPickerView()
//        picker.delegate = self
//        picker.dataSource = self
//        return picker
//    }()
//
//    lazy var segmentController:UISegmentedControl = {
//        let segment = UISegmentedControl(items: isOpenArray)
//        segment.selectedSegmentIndex = 2
//        segment.selectedSegmentTintColor = #colorLiteral(red: 0.1316526234, green: 0, blue: 1, alpha: 1)
//        segment.addTarget(self, action: #selector(handleSegmentControllerValueChanged), for: .valueChanged)
//        return segment
//    }()
//
//    lazy var limitSliderView:UISlider = {
//        let limitSlider = UISlider()
//        limitSlider.minimumValue = 1
//        limitSlider.maximumValue = 50
//        limitSlider.tintColor = UIColor.blue
//        limitSlider.value = 20
//        limitSlider.addTarget(self, action: #selector(handleLimitSliderValueChange(sender:)), for: .valueChanged)
//        return limitSlider
//    }()
//
//    lazy var distanceRangeSliderView:UISlider = {
//        let limitSlider = UISlider()
//        limitSlider.minimumValue = 200
//        limitSlider.maximumValue = 40000
//        limitSlider.tintColor = UIColor.blue
//        limitSlider.value = 2000
//        limitSlider.addTarget(self, action: #selector(handleDistanceRangeSliderValueChange(sender:)), for: .valueChanged)
//        return limitSlider
//    }()
//
//    lazy var resetFilterButton:UIButton = {
//        let button = UIButton()
//        button.setTitle("Reset", for: .normal)
//        button.titleLabel?.font =  UIFont(name: "HelveticaNeue", size: 15)
//        button.setTitleColor(.blue, for: .normal)
//        button.layer.cornerRadius = 5
//        button.backgroundColor = .white
//        return button
//    }()
//
//    lazy var updateFilterButton:UIButton = {
//        let button = UIButton()
//        button.setTitle("Update", for: .normal)
//        button.titleLabel?.font =  UIFont(name: "HelveticaNeue-Bold", size: 18)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 5
//        button.backgroundColor = .blue
//        button.addTarget(self, action: #selector(handleUpdateButtonPressed), for: .touchUpInside)
//        return button
//    }()
//
//    lazy var deemView:UIView = {
//        let deemView = UIView()
//        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(dismissDeemView))
//        tapGuesture.numberOfTapsRequired = 1
//        deemView.backgroundColor = UIColor(white: 0, alpha: 0.6)
//        deemView.alpha = 0
//        deemView.addGestureRecognizer(tapGuesture)
//        return deemView
//    }()
    
    lazy var backgroundImageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        return image
    }()
    
    lazy var welcomeLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: "Welcome")
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = .white
        return label
    }()
    
    lazy var selectionLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: "Make a selection")
        label.textColor = .white
        return label
    }()
//    lazy var menuButton:UIButton = {
//        let button = UIButton()
//        let filterImage = UIImage(named: "menu")
//        button.setImage(filterImage, for: .normal)
//        button.addTarget(self, action:  #selector(handleMenuButtonPressed), for: .touchUpInside)
//        button.contentMode = .scaleToFill
//        return  button
//    }()
    
    lazy var profileImage:UIImageView = {
        let guesture = UITapGestureRecognizer(target: self, action: #selector(presentUpdateProfileVC(sender:)))
        guesture.numberOfTapsRequired = 1
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
        image.image = UIImage(named: "profileImage")
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFill
        image.addGestureRecognizer(guesture)
        return image
    }()
    
    lazy var categoryButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.alpha = 0.7
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleCategoryPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var categoryLabel:UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont(name: "AcademyEngravedLetPlain", size: 55)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 0.5
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        return label
    }()
    
    lazy var favoriteButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleFavoriteButtonPressed), for: .touchUpInside)
        button.backgroundColor = .black
        button.alpha = 0.7
        button.layer.cornerRadius = 20
        button.isUserInteractionEnabled = true
        return button
    }()
    
    lazy var savedLabel:UILabel = {
        let label = UILabel()
        label.text = "Saved"
        label.font = UIFont(name: "AcademyEngravedLetPlain", size: 55)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 0.5
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        return label
    }()
    //MARK:-- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
       // setupFilterView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupProfileImage()
        setupWelcomeLabel()
        hideNavigationBar()
    }
    
    //MARK:-- Objc functions
//
//    @objc func handleMenuButtonPressed(){
//        filterMenuViewTopConstraints?.isActive = false
//        newfilterMenuViewTopConstraints?.isActive = true
//        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.80, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//            self.deemView.alpha = 1
//            self.view.layoutIfNeeded()
//        }, completion: nil)
//    }
//
//    @objc func dismissDeemView(){
//
//        filterMenuViewTopConstraints?.isActive = true
//        newfilterMenuViewTopConstraints?.isActive = false
//        UIView.animate(withDuration: 0.3, animations: {
//            self.deemView.alpha = 0
//            self.view.layoutIfNeeded()
//        }, completion: nil)
//    }
    
    @objc func handleCategoryPressed(){
        
        let categoryVC = CategoryViewController()
        let categoryVCWithNav =  UINavigationController(rootViewController: categoryVC)
        categoryVCWithNav.modalPresentationStyle = .fullScreen
        present(categoryVCWithNav, animated: true)
    }
    
//    @objc func handleDistanceRangeSliderValueChange(sender:UISlider){
//        print(Int(sender.value))
//        distanceLabel.text = "Distance \(Int(sender.value)) mile range"
//    }
//
//    @objc func handleLimitSliderValueChange(sender:UISlider){
//        limitLabel.text = "Limit \(Int(sender.value))"
//    }
    
    @objc func presentUpdateProfileVC(sender:UITapGestureRecognizer){
        let updateProfileVC = UpdateUserProfileViewController()
        updateProfileVC.modalPresentationStyle = .fullScreen
        present(updateProfileVC, animated: true, completion: nil)
    }
    
    @objc func handleFavoriteButtonPressed(){
        let favoriteVC = FavoriteViewController()
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
//    @objc func handlePriceButtonPressed(sender:UIButton){
//        buttonArray.forEach { (button) in
//            switch button.tag{
//            case 0:
//                priceTiers?.append(.oneDollarSign)
//            case 1:
//                priceTiers?.append(.twoDollarSigns)
//            case 2:
//                priceTiers?.append(.threeDollarSigns)
//            case 3:
//                priceTiers?.append(.fourDollarSigns)
//            default:
//                return
//            }
//        }
//    }
//
//    @objc func handleSegmentControllerValueChanged(sender:UISegmentedControl){
//        switch sender.selectedSegmentIndex{
//        case 0:
//            openNow = true
//        case 1:
//            openNow = false
//        case 2:
//            openNow = nil
//        default:
//            return
//        }
//    }
//
//    @objc func handleUpdateButtonPressed(){
//        filterParameter = FilterModel(sortBy: pickerViewPick ?? nil , price: priceTiers ?? [.oneDollarSign, .twoDollarSigns, .threeDollarSigns, .fourDollarSigns], limit: Int(limitSliderView.value), distance: Int(distanceRangeSliderView.value), openNow: openNow ?? nil)
//
//        filterMenuViewTopConstraints?.isActive = true
//        newfilterMenuViewTopConstraints?.isActive = false
//        UIView.animate(withDuration: 0.3, animations: {
//            self.deemView.alpha = 0
//            self.view.layoutIfNeeded()
//        }, completion: nil)
//    }
    //MARK: Private Methods
    
    private func setupView(){
        backgroundImageViewConstraints()
        configureWelcomeLabelConstraints()
        configureSelectionLabelConstraints()
        configureCategoryButtonConstraints()
        configureCategoryLabelConstraints()
        configureRandomButtonnConstraints()
       // configureMenuButtonConstraints()
        configureProfileImageConstraint()
        savedLabelConstriants()
    }
    
//    private func setupFilterView(){
//        configueDeemViewConstraints()
//        configureFilterMenuHeightConstraint()
//        configureFilterLabelConstraints()
//        configureUpdateFilterButton()
//        configurePickerViewConstraints()
//        configureResetFilterButton()
//        configureSortByLabelConstraints()
//        firstLineSeporatorConstraint()
//        configurePriceButtonStackView()
//        configurePriceLabelConstraints()
//        secondLineSeporatorConstraint()
//        configureSegmentControllerConstraints()
//        thirdLineSeporatorConstraint()
//        configurelimitSliderViewConstraints()
//        configureLimitLabelConstraints()
//        configureDistanceRangeSliderViewConstraints()
//        configureDistanceLabelConstraints()
//    }
    
    private func hideNavigationBar(){
        navigationController?.isNavigationBarHidden = true
    }
    private func setupProfileImage(){
        let placeholderImage =  UIImage(systemName: "photo")?.withTintColor(.black)
        guard let currentUser = FirebaseAuthService.manager.currentUser else {return}
        profileImage.kf.setImage(with: currentUser.photoURL, placeholder: placeholderImage)
    }
    
    private func setupWelcomeLabel(){
        guard let currentUser = FirebaseAuthService.manager.currentUser else {return}
        welcomeLabel.text = "Welcome \(currentUser.displayName?.capitalized ?? "")"
    }
    private func addToStackViewButtons(array : [UIButton]) -> UIStackView {
        let sv = UIStackView(arrangedSubviews: array)
        sv.distribution = .fillEqually
        sv.spacing = 3
        sv.axis = .horizontal
        return sv
    }
//    private func createButtonView() -> UIButton{
//        let button = UIButton()
//        button.layer.cornerRadius = 4
//        button.backgroundColor = .lightGray
//        button.addTarget(self, action: #selector(handlePriceButtonPressed), for: .touchUpInside)
//        return button
//    }
    
    private func createUILableView(name:String, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.textAlignment = textAlignment
        label.text = name
        
        return label
    }
    
    private func createHairLineView()-> UIView{
        let hairLine = UIView()
        hairLine.backgroundColor = .lightGray
        return hairLine
    }
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
