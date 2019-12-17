//
//  FoodImagesViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/21/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import CoreLocation

class FoodImagesViewController: UIViewController {
    enum FoodImageIdentifier:String{
        case foodCell
    }
    
    //MARK: -- CoreLocation Coordinate
    let plus = UIImage(systemName: "plus")
    let checkmark = UIImage(systemName: "checkmark")
    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    var userFoodImageSelection = [ CDYelpBusiness]()
    //MARK: UI Objects
    
    var userCategorySlecetedResults = [ CDYelpBusiness](){
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
                
                CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: nil, location: nil, latitude: userLocation.latitude, longitude: userLocation.longitude, radius: filter.distance, categories: categories, locale: .english_unitedStates, limit: filter.limit, offset: 0, sortBy: filter.sortBy, priceTiers: filter.price , openNow: filter.openNow, openAt: nil, attributes: nil) { (response) in
                    guard let response = response, let businesses = response.businesses, businesses.count > 0  else {
                        self.showAlert(alertTitle: "Sorry no results where found", alertMessage: "Increase your search distance in the filter and try again", actionTitle: "OK")
                        return }
                    self.userCategorySlecetedResults = businesses
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
        layout.scrollDirection = .horizontal
        cv.register(FoodImagesSellectionCollectionViewCell.self, forCellWithReuseIdentifier: FoodImageIdentifier.foodCell.rawValue)
        cv.backgroundColor = .clear
        return cv
    }()
    
    lazy var transparentView:UIView = {
        let tv = UIView(frame: UIScreen.main.bounds)
        tv.layer.cornerRadius = 10
        tv.layer.masksToBounds = true
        tv.clipsToBounds = true
        tv.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    lazy var scrollDownIndicator:UIImageView = {
        let gifImage = UIImageView()
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = transparentView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(name: "scrollDownGif")
        return gifImage
    }()
    
    lazy var scrollLabel:UILabel = {
        let label = UILabel()
        label.text = "Scoll image into the pot"
        label.textColor = .white
        label.font = label.font.withSize(15)
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
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        locationManager.delegate = self
        checkLocationAuthorization()
        setupCollectionView()
        configureBackgroundImageViewConstraints()
        configureCollectionviewConstraints()
        // configureTransparentViewConstraints()
        // configureScrollDownIndicatorConstraints()
        // configureScrollLabelConstraints()
        constraintsActivityIndicatorConstraints()
        configureContinueButtomConstraints()
    }
    
    // MARK: objc function
    @objc func handleContinueButtonPressed(sender:UIButton){
        print("continue button pressed")
    }
    
    // MARK: Private function
    
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
    
    //MARK: Private constraints func
    private func configureCollectionviewConstraints(){
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: pointEstimator.relativeHeight(multiplier: 0.1754)), collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor), collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor), collectionView.heightAnchor.constraint(equalToConstant: pointEstimator.relativeHeight(multiplier: 0.6887))])
    }
    
    private func configureBackgroundImageViewConstraints(){
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([backgroundImageView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor), backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor), backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor), backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func configureTransparentViewConstraints(){
        self.view.addSubview(transparentView)
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([transparentView.heightAnchor.constraint(equalToConstant: 200), transparentView.widthAnchor.constraint(equalToConstant: 180), transparentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor), transparentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])
    }
    
    private func configureScrollDownIndicatorConstraints(){
        self.transparentView.addSubview(scrollDownIndicator)
        scrollDownIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([scrollDownIndicator.topAnchor.constraint(equalTo: transparentView.topAnchor, constant: 30), scrollDownIndicator.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor), scrollDownIndicator.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor) ,scrollDownIndicator.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor)])
    }
    
    private func configureScrollLabelConstraints(){
        self.transparentView.addSubview(scrollLabel)
        scrollLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([scrollLabel.topAnchor.constraint(equalTo: transparentView.topAnchor), scrollLabel.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor), scrollLabel.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor) , scrollLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func constraintsActivityIndicatorConstraints(){
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func configureContinueButtomConstraints(){
        view.addSubview(continueButtom)
        continueButtom.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([continueButtom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), continueButtom.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20), continueButtom.heightAnchor.constraint(equalToConstant: 50), continueButtom.widthAnchor.constraint(equalTo: continueButtom.heightAnchor)])
    }
}

//MARK: Extensions
extension FoodImagesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? FoodImagesSellectionCollectionViewCell else {return}
        let info = userCategorySlecetedResults[indexPath.row]
        
        //  Handle button clicked and appending to array
    }
}

extension FoodImagesViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCategorySlecetedResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodImageIdentifier.foodCell.rawValue, for: indexPath) as? FoodImagesSellectionCollectionViewCell else {return UICollectionViewCell()}
        var categoryList:String = ""
        cell.delegate = self
        cell.foodColorBadge.tag = indexPath.item
        let info = userCategorySlecetedResults[indexPath.row]
        
        ImageHelper.shared.getImage(url: info.imageUrl!) { (result) in
            switch result{
            case .failure(let error):
                self.showAlert(alertTitle: "Error", alertMessage: "URL cant be converted to an image \(error)", actionTitle: "OK")
            case .success(let image):
                DispatchQueue.main.async {
                    cell.foodImage.image = image
                }
            }
        }
        
        switch info.rating{
        case 0.0:
            cell.starRatings.image = UIImage(named: "stars_0")
        case 1.0:
            cell.starRatings.image = UIImage(named: "stars_1")
        case 1.5:
            cell.starRatings.image = UIImage(named: "stars_1half")
        case 2.0:
            cell.starRatings.image = UIImage(named: "stars_2")
        case 2.5:
            cell.starRatings.image = UIImage(named: "stars_2half")
        case 3.0:
            cell.starRatings.image = UIImage(named: "stars_3")
        case 3.5:
            cell.starRatings.image = UIImage(named: "stars_3half")
        case 4.0:
            cell.starRatings.image = UIImage(named: "stars_4")
        case 4.5:
            cell.starRatings.image = UIImage(named: "stars_4half")
        case 5.0:
            cell.starRatings.image = UIImage(named: "stars_5")
        default:
            cell.starRatings.image = UIImage(named: "stars_0")
            
        }
        
        for category in info.categories!{
            if let category = category.title{
                categoryList += "\(category) "
            }
        }
        
        cell.categoryNameLabel.text = categoryList
        cell.FoodTitleLabel.text = info.name
        
        CustomLayer.shared.createCustomlayers(layer: cell.layer, cornerRadius: 2, backgroundColor: UIColor.white.cgColor)
        cell.layer.cornerRadius = 25
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
    func addSelectedFood(tag: Int) {
        let info = userCategorySlecetedResults[tag]
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
