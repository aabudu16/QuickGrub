//
//  FoodImagesViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/21/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseFirestore
import FirebaseAuth


class FoodImagesViewController: UIViewController {
    var userInfo:UserProfile? {
        didSet{
            if userInfo?.isInformed == false {
                configureDimViewConstraints()
            }else{
                collectionView.isUserInteractionEnabled = true
            }
        }
    }
    //MARK: -- CoreLocation Coordinate
    let plus = UIImage(systemName: "plus")
    let checkmark = UIImage(systemName: "checkmark")
    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    var userFoodImageSelection = [CDYelpBusiness](){
        didSet{
            if userFoodImageSelection.count > 0 {
                UIView.animate(withDuration: 0.5) {
                    self.continueButtom.alpha = 1
                    self.continueButtom.isEnabled = true
                }
            }else{
                UIView.animate(withDuration: 0.5) {
                    self.continueButtom.alpha = 0
                    self.continueButtom.isEnabled = false
                }
            }
        }
    }
    //MARK: UI Objects
    
    var userCategorySelectedResults = [ CDYelpBusiness](){
        didSet{
            self.collectionView.reloadData()
        }
    }
    var userFilteredParameter: UserFullFilterModel!
    
    var locations:[CLLocation]!{
        didSet{
            
            if let userLocation = locationManager.location?.coordinate{
                let filter = userFilteredParameter.filterModel
                let categories = userFilteredParameter.categories
                
                CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: nil, location: nil, latitude: userLocation.latitude, longitude: userLocation.longitude, radius: filter.distance, categories: categories, locale: .english_unitedStates, limit: filter.limit, offset: 0, sortBy: filter.sortBy, priceTiers: filter.price , openNow: filter.openNow, openAt: nil, attributes: nil) {[weak self] (response) in
                    guard let response = response, let businesses = response.businesses, businesses.count > 0  else {
                        self?.activityIndicator.stopAnimating()
                        self?.popViewControllerAlert()
                        return }
                    DispatchQueue.main.async {
                        self?.userCategorySelectedResults = businesses
                    }
                }
            }
        }
    }
    
    
    lazy var collectionView:UICollectionView = {
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)
        var layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: pointEstimator.relativeWidth(multiplier: 0.73333), height: pointEstimator.relativeHeight(multiplier: 0.45))
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 300), collectionViewLayout: layout)
        let spacingLayout = cv.collectionViewLayout as! UPCarouselFlowLayout
        spacingLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
        layout.scrollDirection = .vertical
        cv.register(FoodImagesSellectionCollectionViewCell.self, forCellWithReuseIdentifier: FoodImageIdentifier.foodCell.rawValue)
        cv.backgroundColor = .clear
        cv.isUserInteractionEnabled = false
        return cv
    }()
    
    lazy var dimView:UIView = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleEnablingCollectionView(guesture:)))
        tap.numberOfTouchesRequired = 1
        let tv = UIView(frame: UIScreen.main.bounds)
        tv.layer.cornerRadius = 10
        tv.layer.masksToBounds = true
        tv.clipsToBounds = true
        tv.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        tv.isUserInteractionEnabled = true
        tv.addGestureRecognizer(tap)
        return tv
    }()
    
    lazy var checkMarkIndicatorView:UIView = {
        let tv = UIView(frame: UIScreen.main.bounds)
        tv.layer.cornerRadius = 10
        tv.layer.masksToBounds = true
        tv.clipsToBounds = true
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    lazy var checkMarkIndicator:UIImageView = {
        let gifImage = UIImageView()
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = checkMarkIndicatorView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(name: "checkMarkAnimate")
        return gifImage
    }()
    
    lazy var instructionLabelView:UIView = {
        let tv = UIView(frame: UIScreen.main.bounds)
        tv.layer.cornerRadius = 10
        tv.layer.masksToBounds = true
        tv.clipsToBounds = true
        tv.blurView.setup(style: UIBlurEffect.Style.dark, alpha: 0.6).enable()
        tv.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        tv.isUserInteractionEnabled = false
        return tv
    }()
    lazy var instructionLabel:UILabel = {
        let label = UILabel()
        label.text = "Tap on the icon to select item, Tap the icon again to de-select item"
        label.textColor = .white
        label.font = label.font.withSize(20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var backgroundImageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "swipePageImage")
        return image
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView()
        av.style = .large
        av.hidesWhenStopped = true
        av.color = .red
        av.startAnimating()
        return av
    }()
    
    lazy var continueButtom:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.backgroundColor = .black
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        button.layer.shadowRadius = 20.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        button.alpha = 0
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleContinueButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rightBarButton:UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(handleFilterButtonPressed(sender:)))
        button.tintColor = .black
        return button
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        locationManager.delegate = self
        addSubview()
        addRightBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLocationAuthorization()
        setupCollectionView()
        configureBackgroundImageViewConstraints()
        configureCollectionviewConstraints()
        getUserInfo()
        configureInstructionLabelViewConstraints()
        configureInstructionLabelConstraints()
        configureCheckMarkIndicatorViewConstraints()
        configureCheckMarkIndicatorConstraints()
        constraintsActivityIndicatorConstraints()
        configureContinueButtomConstraints()
        self.collectionView.reloadData()
    }
    // MARK: objc function
    @objc func handleContinueButtonPressed(sender:UIButton){
        let resturantResultVC = RestaurantResultsViewController()
        resturantResultVC.userFoodImageSelection = userFoodImageSelection
        navigationController?.pushViewController(resturantResultVC, animated: true)
        print("continue button pressed")
    }
    
    @objc func handleEnablingCollectionView(guesture:UITapGestureRecognizer){
        FirestoreService.manager.updateCurrentUserIsInformedField { (result) in
            switch result{
            case .success(()):
                self.dimView.removeFromSuperview()
                self.collectionView.isUserInteractionEnabled = true
                self.checkMarkIndicatorView.removeFromSuperview()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    @objc func handleFilterButtonPressed(sender:UIButton){
        print("filter menu buttpon pressed")
    }
    
    // MARK: Private function
    
    private func addRightBarButton(){
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func getUserInfo(){
        guard let userID = FirebaseAuthService.manager.currentUser?.uid else {
            return
        }
        FirestoreService.manager.getUser(userID: userID) { [weak self](result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let userInfo):
                self?.userInfo = userInfo
            }
        }
    }
    
    private func popViewControllerAlert(){
        let alert = UIAlertController(title: "Sorry no results where found", message: "Increase your search distance in the filter and try again", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .cancel) { (pop) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    private func checkLocationAuthorization(){
        let status = CLLocationManager.authorizationStatus()
        switch status{
        case .authorizedWhenInUse, .authorizedAlways:
            beginLocationUpdates(locationManager: locationManager)
        case.denied:
            self.showAlert(alertTitle: "Guick Grub has been denied acesss to your location", alertMessage: "To give permission, head to your setting and grant access", actionTitle: "OK")
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            self.showAlert(alertTitle: "This aop has been restricted", alertMessage: "Contact customer service to figureout next step", actionTitle: "OK")
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager){
        locationManager.requestLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

//MARK: Extensions
extension FoodImagesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? FoodImagesSellectionCollectionViewCell else {return}
        let info = userCategorySelectedResults[indexPath.row]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FoodImagesSellectionCollectionViewCell else {return}
        let info = userCategorySelectedResults[indexPath.row]
        
        
    }
}

extension FoodImagesViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCategorySelectedResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodImageIdentifier.foodCell.rawValue, for: indexPath) as? FoodImagesSellectionCollectionViewCell else {return UICollectionViewCell()}
        
        cell.delegate = self
        cell.addItemButton.tag = indexPath.item
        cell.FoodTitleLabel.tag = indexPath.item
        cell.createPulse()
        let info = userCategorySelectedResults[indexPath.row]
        
        cell.configurefoodImagesCellData(yelpImages: info)
        
        activityIndicator.stopAnimating()
        
        if userFoodImageSelection.contains(info){
            cell.itemIsSelected = true
        }else {
            cell.itemIsSelected = false
        }
        return cell
    }
    
}

extension FoodImagesViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(" new location \(locations)")
        self.locations = locations
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Authorization status changed to \(status.rawValue)")
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension FoodImagesViewController: CollectionViewCellDelegate{
    func handleShortCut(tag: Int) {
        guard let cell = collectionView.cellForItem(at: IndexPath(row: tag, section: 0)) as? FoodImagesSellectionCollectionViewCell else {return}
        
        cell.shortCutViewTopAnchor?.isActive = false
        cell.newShortCutViewTopAnchor?.isActive = true
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cell.shortCutView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            cell.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func addSelectedFood(tag: Int) {
        let info = userCategorySelectedResults[tag]
        guard let cell = collectionView.cellForItem(at: IndexPath(row: tag, section: 0)) as? FoodImagesSellectionCollectionViewCell else {return}
        
        if cell.itemIsSelected == false{
            print(tag)
            userFoodImageSelection.append(info)
            print("Amount \(userFoodImageSelection.count)")
            cell.itemIsSelected = true
        }else{
            print("Take care of deleting from array at that index")
            cell.itemIsSelected = false
            
            
        }
        
    }
    
    
}
