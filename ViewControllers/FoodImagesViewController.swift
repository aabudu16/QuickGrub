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
    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    //MARK: UI Objects
    
    var userSlecetedResults = [ CDYelpBusiness]()
    var userFilteredParameter: UserFullFilterModel!{
        didSet{
              self.collectionView.reloadData()
        }
    }
    
    var locations:[CLLocation]!{
        didSet{

            if let userLocation = locationManager.location?.coordinate{
                let filter = userFilteredParameter.filterModel
                let categories = userFilteredParameter.categories
                
                CDYelpFusionKitManager.shared.apiClient.searchBusinesses(byTerm: nil, location: nil, latitude: userLocation.latitude, longitude: userLocation.longitude, radius: filter.distance, categories: categories, locale: .english_unitedStates, limit: filter.limit, offset: 0, sortBy: filter.sortBy, priceTiers: filter.price , openNow: filter.openNow, openAt: nil, attributes: nil) { (response) in
                    DispatchQueue.main.async {
                           guard let response = response, let businesses = response.businesses, businesses.count > 0  else {
                                             self.showAlert(alertTitle: "Sorry no results where found", alertMessage: "Increase your search distance in the filter and try again", actionTitle: "OK")
                                             return }
                                         self.userSlecetedResults = businesses
                                         print(self.userSlecetedResults.toJSON())
                    }
                    }
                }

            }
        }
    
    lazy var collectionView:UICollectionView = {
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)
        var layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: pointEstimator.relativeWidth(multiplier: 0.73333), height: pointEstimator.relativeHeight(multiplier: 0.45))
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        let spacingLayout = cv.collectionViewLayout as! UPCarouselFlowLayout
        spacingLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
        layout.scrollDirection = .horizontal
        cv.register(FoodImagesSellectionCollectionViewCell.self, forCellWithReuseIdentifier: FoodImageIdentifier.foodCell.rawValue)
        cv.backgroundColor = .white
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
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
         checkLocationAuthorization()
        setupCollectionView()
        configureCollectionviewConstraints()
        configureTransparentViewConstraints()
        configureScrollDownIndicatorConstraints()
        configureScrollLabelConstraints()
    }
    
    // MARK: objc function
    @objc func handleFoodColorBadge(){
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        
        self.showAlert(alertTitle: "vegertarian", alertMessage: """
        Vegetarian lifestyles are associated with a reduced
        risk of many chronic illnesses, including heart disease,
        many types of cancer, diabetes, high blood pressure,
        and obesity.
        """, actionTitle: "OK")
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
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: self.view.topAnchor), collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
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
    
}

//MARK: Extensions
extension FoodImagesViewController: UICollectionViewDelegate{}

extension FoodImagesViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userSlecetedResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodImageIdentifier.foodCell.rawValue, for: indexPath) as? FoodImagesSellectionCollectionViewCell else {return UICollectionViewCell()}
        
        let info = userSlecetedResults[indexPath.row]
        cell.foodImage.image = UIImage(systemName: "photo")
        cell.starRatings.image = UIImage(named: "fourStars")
        cell.categoryNameLabel.text = "Catergory name"
        cell.FoodTitleLabel.text = info.name
        cell.foodColorBadge.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFoodColorBadge)))
        
        CustomLayer.shared.createCustomlayers(layer: cell.layer, cornerRadius: 2, backgroundColor: UIColor.blue.cgColor)
        cell.layer.cornerRadius = 25
        collectionView.reloadData()
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

