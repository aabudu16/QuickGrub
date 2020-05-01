//
//  RestaurantDetailViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/28/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import Kingfisher
import CoreLocation
import MapKit
import SafariServices

class RestaurantDetailViewController: UIViewController {
    
    
    //MARK: - UIObjects
    let image = UIImage(named: "FoodPlaceholder")
    var business:CDYelpBusiness!{
        didSet{
            // populate business data
            populateBusinessData(business: business)
            // ratings images
           addRatingStarImage()
        }
    }
    
    lazy var imageScrollView:UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.isPagingEnabled = true
        return view
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.hidesForSinglePage = true
        pc.pageIndicatorTintColor = .blue
        pc.currentPageIndicatorTintColor = .red
        return pc
    }()
    
    lazy var logoView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 60))
        view.backgroundColor = #colorLiteral(red: 0.9692103267, green: 0.9634483457, blue: 0.9736391902, alpha: 1)
        view.layer.borderWidth = 0.5
        view.layer.shadowOpacity = 0.1
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    lazy var logoLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Savoye LET", size: 30)
        label.textColor = .black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var badgeImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "foodBadge")
        return iv
    }()
    lazy var restaurantName:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Avenir-Heavy", size: 23)
        return label
    }()
    
    lazy var addressTextView:UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.textAlignment = .left
        tv.adjustsFontForContentSizeCategory = false
        tv.isUserInteractionEnabled = false
        tv.font = UIFont(name: "Avenir-Light", size: 18)
        return tv
    }()
    
    lazy var businessMenuButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "menu-1"), for: .normal)
        button.addTarget(self, action: #selector(handleBusinessMenuButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var  starRatings:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var reviewCountLabel:UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4234377742, green: 0.4209252, blue: 0.4253720939, alpha: 1)
        label.font = UIFont(name: "Avenir-Light", size: 15)
        return label
    }()
    lazy var hoursOfOperationTextView:UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.textAlignment = .left
        tv.adjustsFontForContentSizeCategory = false
        tv.isUserInteractionEnabled = false
        tv.font = UIFont(name: "Avenir-Light", size: 16)
        tv.text = """
        Sunday         11:30AM – 2.20AM
        Monday        11:30AM – 2AM
        Tuesday        11:30AM – 2AM
        Wednesday  11:30AM – 2AM
        Thursday      11:30AM – 2AM
        Friday           11:30AM – 3.30AM
        Saturday       11:30AM – 3AM
        """
        return tv
    }()
    
    lazy var openOrCloseLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 18)
        label.textAlignment = .center
        return label
    }()
    
    lazy var restaurantPhoneNumber:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Light", size: 18)
        return label
    }()
    
    lazy var containerView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var aboutButton:UIButton = {
        let button = UIButton()
        button.setTitle("About", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 20)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(handleAboutButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var reviewButton:UIButton = {
        let button = UIButton()
        button.setTitle("Reviews", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 20)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(handleReviewButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var navigateButtom:UIButton = {
        let button = UIButton()
        button.setTitle("Direction", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 18)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setScrollViewDelegate()
        setupNavigationBarButtons()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateImageScrollView()
        configureImageScrollViewConstraints()
        configurePageControlConstraints()
        configureLogoViewConstraints()
        configureLogoLabelConstraints()
        configureBadgeImageViewConstraints()
        configureResturantNameConstraints()
        configureAddressTextViewConstraints()
        configureRestaurantPhoneNumberConstraints()
        configureFoodMenuButtonConstraints()
        configureStarRatingsLabelConstraints()
        configureRatingsCountConstraints()
        configureContainerViewConstraints()
        configureAboutButtonConstraints()
        configureReviewButtonConstraints()
        configureHoursOfOperationTextViewConstraints()
        configureNavigateButtomConstraints()
    }
    
    //MARK:@Objc function
    @objc func getDirections(sender:UIButton){
        guard let lat = business.coordinates?.latitude, let long =  business.coordinates?.longitude else {return}
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = business.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    @objc func handleAboutButtonPressed(sender:UIButton){
        
        guard let businessURL = business.url else {
            self.showAlert(alertTitle: "Sorry", alertMessage: "Cant access \(business.name ?? "the business") link on YELP.", actionTitle: "OK")
            return
        }
        self.showSafariVC(for: businessURL)

    }
    
    @objc func handleReviewButtonPressed(sender:UIButton){
        guard let businessID = business.id else {
            self.showAlert(alertTitle: nil, alertMessage: "Cant access \(business.name ?? "the business") review on YELP.", actionTitle: "OK")
            return}
        
        let customerReviewVC = CustomerReviewsViewController()
        customerReviewVC.businessID = businessID
        customerReviewVC.modalPresentationStyle = .popover
        present(customerReviewVC, animated: true) {
            UIView.animate(withDuration: 0.4) {
                customerReviewVC.dismissButton.backgroundColor = #colorLiteral(red: 0.8273282647, green: 0.1290322244, blue: 0.0612013787, alpha: 1)
            }
        }
    }
    
    @objc func handleBusinessMenuButtonPressed(sender:UIButton){
        print("Menu button pressed")
    }
    
    @objc func handleFavoriteButtonPressed(sender:UIBarButtonItem){
        guard let businessInfo = business else {return}
         guard let currentUser = FirebaseAuthService.manager.currentUser else {return}
         
        let myFavorite = UserFavorite(creatorID:  currentUser.uid, venueID: businessInfo.id!, name: businessInfo.name!)
         
        createFavorites(favorite: myFavorite)
    }
    
    @objc func handleShareButtonPressed(sender:UIBarButtonItem){
        
        guard let businessURL = business.url else {return}
        let share = UIActivityViewController(activityItems: [businessURL], applicationActivities: nil)
        present(share, animated: true, completion: nil)
    }
    
    //MARK:Private function
    private func populateImageScrollView(){
        if let photoArray = self.business.photos{
            for (index, photoString) in photoArray.enumerated(){
                self.pageControl.numberOfPages = photoArray.count
                let image = UIImage(named: "FoodPlaceholder")
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill
                let imageUrl = URL(string: photoString)
                DispatchQueue.main.async {
                    
                    imageView.kf.setImage(with: imageUrl, placeholder: image, options: [.transition(.fade(0.2))])
                    imageView.setNeedsDisplay()
                    let xPosition:CGFloat = self.view.frame.width * CGFloat(index)
                    imageView.frame = CGRect(x: xPosition, y: 0, width: self.imageScrollView.frame.width, height: self.imageScrollView.frame.height)
                    
                    self.imageScrollView.contentSize.width = self.imageScrollView.frame.width * CGFloat(index + 1)
                    self.imageScrollView.addSubview(imageView)
                }
            }
        }
    }
    
    private func populateBusinessData(business: CDYelpBusiness){
        
        logoLabel.text = business.name
        restaurantName.text = business.name
        restaurantPhoneNumber.text = business.displayPhone
        
        if let businessAddress = business.location?.displayAddress {
                   if businessAddress.count > 1 {
                       addressTextView.text = "\(businessAddress[0]) \(businessAddress[1])"
                   } else {
                       addressTextView.text = "\(businessAddress.first ?? "")"
                   }
               }
        
        // review count
        if let reviewCount = business.reviewCount{
            reviewCountLabel.text = "\(reviewCount) Ratings"
        }
        
        // hours of operation
        if let hours = business.hours{
            if let unWrappedHours = hours.first.flatMap({$0.open}){
                unWrappedHours.forEach({print($0.toJSON())})
            }
        }
    }
    
    private func addRatingStarImage(){
        switch business.rating{
        case 0.0:
            starRatings.image = UIImage(named: "stars_0")
        case 1.0:
            starRatings.image = UIImage(named: "stars_1")
        case 1.5:
            starRatings.image = UIImage(named: "stars_1half")
        case 2.0:
            starRatings.image = UIImage(named: "stars_2")
        case 2.5:
            starRatings.image = UIImage(named: "stars_2half")
        case 3.0:
            starRatings.image = UIImage(named: "stars_3")
        case 3.5:
            starRatings.image = UIImage(named: "stars_3half")
        case 4.0:
            starRatings.image = UIImage(named: "stars_4")
        case 4.5:
            starRatings.image = UIImage(named: "stars_4half")
        case 5.0:
            starRatings.image = UIImage(named: "stars_5")
        default:
            starRatings.image = UIImage(named: "stars_0")
        }
    }
    
    private func createFavorites(favorite: UserFavorite){
        FirestoreService.manager.createFavorite(favorite: favorite) { (result) in
            switch result{
            case .failure(let error):
                self.showAlert(alertTitle: "Error", alertMessage: "Seems to have a problem adding this item to your favorites. please try again \(error)", actionTitle: "OK")
            case .success(()):
                self.showAlert(alertTitle: "Success", alertMessage: "Added to your favorites", actionTitle: "OK")
            }
        }
    }
    
    private func setScrollViewDelegate(){
        imageScrollView.delegate = self
    }
    
    private func setupNavigationBarButtons(){
        let favorite = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(handleFavoriteButtonPressed(sender:)))
        let share = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(handleShareButtonPressed(sender:)))
        
        favorite.tintColor = .black
        share.tintColor = .black
        navigationItem.rightBarButtonItems = [favorite, share]
        
    }
    
    private func createHairLineView()-> UIView{
        let hairLine = UIView()
        hairLine.backgroundColor = .lightGray
        return hairLine
    }
}

extension RestaurantDetailViewController: UIScrollViewDelegate{
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
                   pageControl.currentPage = Int(page)
    }
}

extension RestaurantDetailViewController: SFSafariViewControllerDelegate{
    
}

