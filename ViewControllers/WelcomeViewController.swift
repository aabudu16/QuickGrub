//
//  WelcomeViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import FirebaseAuth


// remove constant: -400 from the constraints of filter Menu Height
class WelcomeViewController: UIViewController {
    
    let CDYelpBusinessSortType:Array = ["best match", "rating", "review count", "distance"]
    let isOpenArray = ["Open", "Close", "Both"]
    var pickerViewPick:CDYelpBusinessSortType?
    var priceTiers:[CDYelpPriceTier]?
    var filterParameter:FilterModel?
    var openNow:Bool?
    
    //MARK: UI Objects
    let filterMenuHeight:CGFloat = 400
    
    var distanceLabel:UILabel!
    var limitLabel:UILabel!
    var buttonArray = [UIButton]()
    var stackView:UIStackView!
    lazy var filterMenuView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var filterLabel:UILabel = {
        let label = UILabel()
        label.text = "Filter"
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 28)
        return label
    }()
    
    lazy var pickerView:UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    lazy var segmentController:UISegmentedControl = {
        let segment = UISegmentedControl(items: isOpenArray)
        segment.selectedSegmentIndex = 2
        segment.selectedSegmentTintColor = #colorLiteral(red: 0.1316526234, green: 0, blue: 1, alpha: 1)
        segment.addTarget(self, action: #selector(handleSegmentControllerValueChanged), for: .valueChanged)
        return segment
    }()
    
    lazy var limitSliderView:UISlider = {
        let limitSlider = UISlider()
        limitSlider.minimumValue = 1
        limitSlider.maximumValue = 50
        limitSlider.tintColor = UIColor.blue
        limitSlider.value = 20
        limitSlider.addTarget(self, action: #selector(handleLimitSliderValueChange(sender:)), for: .valueChanged)
        return limitSlider
    }()
    
    lazy var distanceRangeSliderView:UISlider = {
        let limitSlider = UISlider()
        limitSlider.minimumValue = 200
        limitSlider.maximumValue = 40000
        limitSlider.tintColor = UIColor.blue
        limitSlider.value = 2000
        limitSlider.addTarget(self, action: #selector(handleDistanceRangeSliderValueChange(sender:)), for: .valueChanged)
        return limitSlider
    }()
    
    lazy var resetFilterButton:UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.titleLabel?.font =  UIFont(name: "HelveticaNeue", size: 15)
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .white
        return button
    }()
    
    lazy var updateFilterButton:UIButton = {
        let button = UIButton()
        button.setTitle("Update", for: .normal)
        button.titleLabel?.font =  UIFont(name: "HelveticaNeue-Bold", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(handleUpdateButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var deemView:UIView = {
        let deemView = UIView()
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(dismissDeemView))
        deemView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        deemView.alpha = 0
        deemView.addGestureRecognizer(tapGuesture)
        return deemView
    }()
    
    lazy var welcomeLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: "Welcome")
        return label
    }()
    
    lazy var selectionLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: "Make a selection")
        return label
    }()
    lazy var menuButton:UIButton = {
        let button = UIButton()
        let filterImage = UIImage(named: "menu")
        button.setImage(filterImage, for: .normal)
        button.addTarget(self, action:  #selector(handleMenuButtonPressed), for: .touchUpInside)
        button.contentMode = .scaleToFill
        return  button
    }()
    
    lazy var logoutButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logoutIcon2"), for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    lazy var profileImage:UIImageView = {
        let guesture = UITapGestureRecognizer(target: self, action: #selector(imageViewDoubleTapped(sender:)))
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
        let button = UIButton(image: UIImage(named: "category")!, color: UIColor.white.cgColor)
        button.addTarget(self, action: #selector(handleCategoryPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var favoriteButton:UIButton = {
        let button = UIButton(image: UIImage(named: "category")!, color: UIColor.white.cgColor)
        button.addTarget(self, action: #selector(handleFavoriteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupFilterView()
        
    }
    
    //MARK: Objc Selector functions
    
    @objc func handleMenuButtonPressed(){
        if let window = UIApplication.shared.keyWindow{
            window.addSubview(deemView)
            window.addSubview(filterMenuView)
            deemView.frame = window.frame
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.80, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.deemView.alpha = 1
                self.filterMenuView.frame = CGRect(x: 0, y: (self.view.frame.height - self.filterMenuHeight) + 20, width: self.view.frame.width, height: self.filterMenuHeight)
            }, completion: nil)
        }
    }
    
    @objc func dismissDeemView(){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.deemView.alpha = 0
            self.filterMenuView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.filterMenuHeight)
        }, completion: { (_) in
            self.deemView.removeFromSuperview()
        })
    }
    
    @objc func handleCategoryPressed(){
        
        let categoryVC = CategoryViewController()
        let categoryVCWithNav =  UINavigationController(rootViewController: categoryVC)
        categoryVCWithNav.modalPresentationStyle = .fullScreen
        present(categoryVCWithNav, animated: true)
        if filterParameter != nil {
            categoryVC.filterParameter = self.filterParameter
        }else{
            categoryVC.filterParameter = GenericParameter.genericSettingParameter
        }
    }
    
    @objc func handleDistanceRangeSliderValueChange(sender:UISlider){
        print(Int(sender.value))
        distanceLabel.text = "Distance \(Int(sender.value)) mile range"
    }
    
    @objc func handleLimitSliderValueChange(sender:UISlider){
        limitLabel.text = "Limit \(Int(sender.value))"
    }
    
    @objc func imageViewDoubleTapped(sender:UITapGestureRecognizer){
        print("Image view tapped")
    }
    
    @objc func handleFavoriteButtonPressed(){
        print("Favorite Button")
    }
    
    @objc func handleLogout(){
        do{
            try Auth.auth().signOut()
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true, completion: nil)
        }catch let error{
            showAlert(with: "Error", and: "Problem logining out \(error)")
        }
    }
    
    @objc func handlePriceButtonPressed(sender:UIButton){
        buttonArray.forEach { (button) in
            switch button.tag{
            case 0:
                priceTiers?.append(.oneDollarSign)
            case 1:
                priceTiers?.append(.twoDollarSigns)
            case 2:
                priceTiers?.append(.threeDollarSigns)
            case 3:
                priceTiers?.append(.fourDollarSigns)
            default:
                return
            }
        }
    }
    
    @objc func handleSegmentControllerValueChanged(sender:UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            openNow = true
        case 1:
            openNow = false
        case 2:
            openNow = nil
        default:
            return
        }
    }
    
    @objc func handleUpdateButtonPressed(){
        filterParameter = FilterModel(sortBy: pickerViewPick ?? nil , price: priceTiers ?? [.oneDollarSign, .twoDollarSigns, .threeDollarSigns, .fourDollarSigns], limit: Int(limitSliderView.value), distance: Int(distanceRangeSliderView.value), openNow: openNow ?? nil)
        
        print(filterParameter!)
        UIView.animate(withDuration: 0.3, animations: {
                   self.deemView.alpha = 0
                   self.filterMenuView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.filterMenuHeight)
               }, completion: { (_) in
                   self.deemView.removeFromSuperview()
               })
    }
    //MARK: Private Methods
    
    private func setupView(){
        view.backgroundColor = .orange
        configureWelcomeLabelConstraints()
        configureSelectionLabelConstraints()
        configureCategoryButtonConstraints()
        configureRandomButtonnConstraints()
        configureLogoutButtonConstraints()
        configureProfileImageConstraint()
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupFilterView(){
        configureFilterMenuHeightConstraint()
        configureFilterLabelConstraints()
        configureUpdateFilterButton()
        configurePickerViewConstraints()
        configureResetFilterButton()
        configureSortByLabelConstraints()
        firstLineSeporatorConstraint()
        configurePriceButtonStackView()
        configurePriceLabelConstraints()
        secondLineSeporatorConstraint()
        configureSegmentControllerConstraints()
        thirdLineSeporatorConstraint()
        configurelimitSliderViewConstraints()
        configureLimitLabelConstraints()
        configureDistanceRangeSliderViewConstraints()
        configureDistanceLabelConstraints()
    }
    
    func addToStackViewButtons(array : [UIButton]) -> UIStackView {
        let sv = UIStackView(arrangedSubviews: array)
        sv.distribution = .fillEqually
        sv.spacing = 3
        sv.axis = .horizontal
        return sv
    }
    private func createButtonView() -> UIButton{
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(handlePriceButtonPressed), for: .touchUpInside)
        return button
    }
    
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
    
    
    //MARK: Constriaints Function
    private func configureWelcomeLabelConstraints(){
        view.addSubview(welcomeLabel)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([welcomeLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10), welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),welcomeLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func configureSelectionLabelConstraints(){
        view.addSubview(selectionLabel)
        
        selectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([selectionLabel.topAnchor.constraint(equalTo: self.welcomeLabel.bottomAnchor, constant: 10), selectionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),selectionLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func configureCategoryButtonConstraints(){
        view.addSubview(categoryButton)
        
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([categoryButton.topAnchor.constraint(equalTo:self.selectionLabel.bottomAnchor, constant: 10), categoryButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20), categoryButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20), categoryButton.heightAnchor.constraint(equalToConstant: 250)])
    }
    
    private func configureRandomButtonnConstraints(){
        view.addSubview(favoriteButton)
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([favoriteButton.topAnchor.constraint(equalTo:self.categoryButton.bottomAnchor, constant: 100), favoriteButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20), favoriteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20), favoriteButton.heightAnchor.constraint(equalTo: categoryButton.heightAnchor)])
    }
    
    private func configureLogoutButtonConstraints(){
        view.addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5), menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10), menuButton.heightAnchor.constraint(equalToConstant: 30), menuButton.widthAnchor.constraint(equalToConstant: 30)])
    }
    
    private func configureProfileImageConstraint(){
        view.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10), profileImage.heightAnchor.constraint(equalToConstant: 50), profileImage.widthAnchor.constraint(equalToConstant: 50)])
    }
    
    private func configureFilterMenuHeightConstraint(){
        view.addSubview(filterMenuView)
        filterMenuView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([filterMenuView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0), filterMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor), filterMenuView.trailingAnchor.constraint(equalTo: view.trailingAnchor), filterMenuView.heightAnchor.constraint(equalToConstant: filterMenuHeight)])
    }
    
    private func configureFilterLabelConstraints(){
        filterMenuView.addSubview(filterLabel)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([filterLabel.topAnchor.constraint(equalTo: filterMenuView.topAnchor), filterLabel.leadingAnchor.constraint(equalTo: filterMenuView.leadingAnchor, constant: 20), filterLabel.trailingAnchor.constraint(equalTo: filterMenuView.trailingAnchor), filterLabel.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    private func configureUpdateFilterButton(){
        filterMenuView.addSubview(updateFilterButton)
        updateFilterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([updateFilterButton.bottomAnchor.constraint(equalTo: filterMenuView.bottomAnchor, constant: -35), updateFilterButton.leadingAnchor.constraint(equalTo: filterMenuView.leadingAnchor, constant: 25),updateFilterButton.trailingAnchor.constraint(equalTo: filterMenuView.trailingAnchor, constant: -25),updateFilterButton.heightAnchor.constraint(equalToConstant: 45)])
    }
    
    private func configureResetFilterButton(){
        filterMenuView.addSubview(resetFilterButton)
        resetFilterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([resetFilterButton.topAnchor.constraint(equalTo: filterMenuView.topAnchor, constant: 10), resetFilterButton.trailingAnchor.constraint(equalTo: filterMenuView.trailingAnchor),resetFilterButton.heightAnchor.constraint(equalToConstant: 20), resetFilterButton.widthAnchor.constraint(equalToConstant: 100)])
    }
    
    private func configurePickerViewConstraints(){
        filterMenuView.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([pickerView.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 5), pickerView.leadingAnchor.constraint(equalTo: filterMenuView.leadingAnchor, constant: 80), pickerView.trailingAnchor.constraint(equalTo: filterMenuView.trailingAnchor, constant: -20),pickerView.heightAnchor.constraint(equalToConstant: 70)])
    }
    
    private func firstLineSeporatorConstraint(){
        let separator = createHairLineView()
        filterMenuView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([separator.topAnchor.constraint(equalTo: pickerView.bottomAnchor), separator.leadingAnchor.constraint(equalTo: filterMenuView.leadingAnchor, constant: 10), separator.trailingAnchor.constraint(equalTo: filterMenuView.trailingAnchor, constant: -10), separator.heightAnchor.constraint(equalToConstant: 1)])
    }
    private func configureSortByLabelConstraints(){
        
        let sortByLabel = createUILableView(name: "Sort by",textAlignment: .left)
        
        filterMenuView.addSubview(sortByLabel)
        sortByLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([sortByLabel.topAnchor.constraint(equalTo: filterLabel.bottomAnchor), sortByLabel.leadingAnchor.constraint(equalTo: filterMenuView.leadingAnchor, constant: 10), sortByLabel.trailingAnchor.constraint(equalTo: pickerView.leadingAnchor),sortByLabel.heightAnchor.constraint(equalTo: pickerView.heightAnchor)])
    }
    
    private func configurePriceButtonStackView(){
        
        for _ in 0...3{
            buttonArray.append(createButtonView())
        }
        
        buttonArray[0].tag = 0
        buttonArray[0].setTitle(priceData.oneDollar.rawValue, for: .normal)
        buttonArray[1].tag = 1
        buttonArray[1].setTitle(priceData.twoDollars.rawValue, for: .normal)
        buttonArray[2].tag = 2
        buttonArray[2].setTitle(priceData.threeDollars.rawValue, for: .normal)
        buttonArray[3].tag = 3
        buttonArray[3].setTitle(priceData.fourDollars.rawValue, for: .normal)
        
        stackView = addToStackViewButtons(array: buttonArray)
        
        filterMenuView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 25), stackView.leadingAnchor.constraint(equalTo: filterMenuView.leadingAnchor, constant: 80), stackView.trailingAnchor.constraint(equalTo: filterMenuView.trailingAnchor, constant: -20), stackView.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    private func configurePriceLabelConstraints(){
        
        let priceLabel = createUILableView(name: "Price",textAlignment: .left)
        
        filterMenuView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([priceLabel.topAnchor.constraint(equalTo: pickerView.bottomAnchor), priceLabel.leadingAnchor.constraint(equalTo: filterMenuView.leadingAnchor, constant: 10), priceLabel.trailingAnchor.constraint(equalTo: pickerView.leadingAnchor),priceLabel.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    private func secondLineSeporatorConstraint(){
        let separator = createHairLineView()
        filterMenuView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([separator.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15), separator.leadingAnchor.constraint(equalTo: filterMenuView.leadingAnchor, constant: 10), separator.trailingAnchor.constraint(equalTo: filterMenuView.trailingAnchor, constant: -10), separator.heightAnchor.constraint(equalToConstant: 1)])
    }
    
    private func configureSegmentControllerConstraints(){
        filterMenuView.addSubview(segmentController)
        segmentController.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([segmentController.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40), segmentController.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 150), segmentController.trailingAnchor.constraint(equalTo: stackView.trailingAnchor), segmentController.heightAnchor.constraint(equalTo: stackView.heightAnchor)])
    }
    
    private func thirdLineSeporatorConstraint(){
        let separator = createHairLineView()
        filterMenuView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([separator.topAnchor.constraint(equalTo: segmentController.bottomAnchor, constant: 15), separator.leadingAnchor.constraint(equalTo: filterMenuView.leadingAnchor, constant: 10), separator.trailingAnchor.constraint(equalTo: filterMenuView.trailingAnchor, constant: -10), separator.heightAnchor.constraint(equalToConstant: 1)])
    }
    
    private func configurelimitSliderViewConstraints(){
        filterMenuView.addSubview(limitSliderView)
        limitSliderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([limitSliderView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant:  40), limitSliderView.leadingAnchor.constraint(equalTo: pickerView.leadingAnchor), limitSliderView.trailingAnchor.constraint(equalTo: segmentController.leadingAnchor, constant:  -25), limitSliderView.heightAnchor.constraint(equalTo: segmentController.heightAnchor)])
    }
    
    private func configureLimitLabelConstraints(){
        
        limitLabel = createUILableView(name: "Limit" ,textAlignment: .left)
        
        filterMenuView.addSubview(limitLabel)
        limitLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([limitLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15), limitLabel.leadingAnchor.constraint(equalTo: filterMenuView.leadingAnchor, constant: 10), limitLabel.trailingAnchor.constraint(equalTo: limitSliderView.leadingAnchor),limitLabel.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    private func configureDistanceRangeSliderViewConstraints(){
        filterMenuView.addSubview(distanceRangeSliderView)
        distanceRangeSliderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([distanceRangeSliderView.topAnchor.constraint(equalTo: segmentController.bottomAnchor, constant: 35), distanceRangeSliderView.leadingAnchor.constraint(equalTo: limitSliderView.leadingAnchor), distanceRangeSliderView.trailingAnchor.constraint(equalTo: filterMenuView.trailingAnchor,constant: -30), distanceRangeSliderView.heightAnchor.constraint(equalTo: segmentController.heightAnchor)])
    }
    
    private func configureDistanceLabelConstraints(){
        
        distanceLabel = createUILableView(name: "Distance",textAlignment: .left)
        filterMenuView.addSubview(distanceLabel)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([distanceLabel.topAnchor.constraint(equalTo: limitSliderView.bottomAnchor, constant: 15), distanceLabel.leadingAnchor.constraint(equalTo: filterMenuView.leadingAnchor, constant: 15), distanceLabel.trailingAnchor.constraint(equalTo: limitSliderView.leadingAnchor, constant: 150), distanceLabel.heightAnchor.constraint(equalToConstant: 30)])
    }
}

extension WelcomeViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row{
        case 0:
            pickerViewPick = .bestMatch
        case 1:
            pickerViewPick = .rating
        case 2:
            pickerViewPick = .reviewCount
        case 3:
            pickerViewPick = .distance
        default:
            pickerViewPick = .none
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CDYelpBusinessSortType[row]
    }
}
