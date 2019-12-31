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

class RestaurantDetailViewController: UIViewController {
    
    //MARK: - UIObjects
    let image = UIImage(named: "FoodPlaceholder")
    var business:CDYelpBusiness!{
        didSet{
            logoLabel.text = business.name
            restaurantName.text = business.name
            if let displayAddress = business.location?.displayAddress{
                addressTextView.text = "\(displayAddress[0]) \(displayAddress[1])"
            }
            
            restaurantPhoneNumber.text = business.displayPhone
            
            // ratings images
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
            
            print(  business.url)
            
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
        tv.font = UIFont(name: "Avenir-Light", size: 19)
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
        label.text = "(718)450-4321"
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
        setScrollViewDelegate()
        setupNavigationBarButtons()
        view.backgroundColor = .white
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        populateImageScrollView()
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
        UIApplication.shared.open(businessURL, options: [:], completionHandler: nil)
    }
    
    @objc func handleReviewButtonPressed(sender:UIButton){
        guard let businessID = business.id else {
            self.showAlert(alertTitle: nil, alertMessage: "Cant access \(business.name ?? "the business") review on YELP.", actionTitle: "OK")
            return}
        
        let customerReviewVC = CustomerReviewsViewController()
        customerReviewVC.businessID = businessID
        customerReviewVC.modalPresentationStyle = .popover
        present(customerReviewVC, animated: true) {
        customerReviewVC.dismissButton.backgroundColor = .red
        }
       // present(customerReviewVC, animated: true, completion: nil)
    }
    
    @objc func handleBusinessMenuButtonPressed(sender:UIButton){
        print("Menu button pressed")
    }
    @objc func handleFavoriteButtonPressed(sender:UIBarButtonItem){
        print("favorite button pressed")
    }
    
    @objc func handleShareButtonPressed(sender:UIBarButtonItem){
        print("favorite button pressed")
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
    
    //MARK: - Private constraints functions
    private func configureImageScrollViewConstraints(){
        view.addSubview(imageScrollView)
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageScrollView.topAnchor.constraint(equalTo: view.topAnchor),imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),imageScrollView.heightAnchor.constraint(equalToConstant: 300)])
    }
    
    private func configurePageControlConstraints(){
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([pageControl.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: -5), pageControl.centerXAnchor.constraint(equalTo: imageScrollView.centerXAnchor), pageControl.heightAnchor.constraint(equalToConstant: 10), pageControl.widthAnchor.constraint(equalToConstant: 30)])
    }
    
    private func configureLogoViewConstraints(){
        view.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([logoView.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: (logoView.layer.frame.height / 2)), logoView.trailingAnchor.constraint(equalTo: imageScrollView.trailingAnchor, constant: -10), logoView.heightAnchor.constraint(equalToConstant: 60), logoView.widthAnchor.constraint(equalToConstant: 90)])
    }
    
    private func configureLogoLabelConstraints(){
        logoView.addSubview(logoLabel)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([logoLabel.topAnchor.constraint(equalTo: logoView.topAnchor, constant: 2),logoLabel.leadingAnchor.constraint(equalTo: logoView.leadingAnchor, constant: 10),logoLabel.trailingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: -2),logoLabel.bottomAnchor.constraint(equalTo: logoView.bottomAnchor)])
    }
    
    private func configureBadgeImageViewConstraints(){
        view.addSubview(badgeImageView)
        badgeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([badgeImageView.topAnchor.constraint(equalTo: logoView.topAnchor,constant: -20), badgeImageView.leadingAnchor.constraint(equalTo: logoView.leadingAnchor, constant: -20), badgeImageView.heightAnchor.constraint(equalToConstant: 45), badgeImageView.widthAnchor.constraint(equalTo: badgeImageView.heightAnchor)])
        
    }
    
    private func configureResturantNameConstraints(){
        view.addSubview(restaurantName)
        restaurantName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([restaurantName.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant:  5), restaurantName.leadingAnchor.constraint(equalTo: imageScrollView.leadingAnchor, constant: 5), restaurantName.heightAnchor.constraint(equalToConstant: 50), restaurantName.trailingAnchor.constraint(equalTo: logoView.leadingAnchor, constant: -35)])
    }
    
    private func configureAddressTextViewConstraints(){
        view.addSubview(addressTextView)
        addressTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([addressTextView.topAnchor.constraint(equalTo: restaurantName.bottomAnchor), addressTextView.leadingAnchor.constraint(equalTo: imageScrollView.leadingAnchor, constant: 5), addressTextView.heightAnchor.constraint(equalToConstant: 75), addressTextView.trailingAnchor.constraint(equalTo: restaurantName.trailingAnchor)])
    }
    
    private func configureRestaurantPhoneNumberConstraints(){
        view.addSubview(restaurantPhoneNumber)
        restaurantPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([restaurantPhoneNumber.topAnchor.constraint(equalTo: addressTextView.bottomAnchor,constant: 0), restaurantPhoneNumber.leadingAnchor.constraint(equalTo: addressTextView.leadingAnchor), restaurantPhoneNumber.heightAnchor.constraint(equalToConstant: 40), restaurantPhoneNumber.widthAnchor.constraint(equalTo: addressTextView.widthAnchor)])
    }
    
    private func configureFoodMenuButtonConstraints(){
        view.addSubview(businessMenuButton)
        businessMenuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([businessMenuButton.topAnchor.constraint(equalTo: logoView.bottomAnchor,constant: 25), businessMenuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5), businessMenuButton.heightAnchor.constraint(equalToConstant: 80), businessMenuButton.widthAnchor.constraint(equalToConstant: 70)])
    }
    
    private func configureStarRatingsLabelConstraints(){
        view.addSubview(starRatings)
        starRatings.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([starRatings.topAnchor.constraint(equalTo: restaurantPhoneNumber.bottomAnchor,constant: 0), starRatings.leadingAnchor.constraint(equalTo: restaurantPhoneNumber.leadingAnchor), starRatings.heightAnchor.constraint(equalToConstant: 30), starRatings.widthAnchor.constraint(equalToConstant: 100)])
    }
    
    private func configureRatingsCountConstraints(){
        view.addSubview(reviewCountLabel)
        reviewCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([reviewCountLabel.topAnchor.constraint(equalTo: starRatings.topAnchor), reviewCountLabel.leadingAnchor.constraint(equalTo: starRatings.trailingAnchor,constant: 3), reviewCountLabel.trailingAnchor.constraint(equalTo: addressTextView.trailingAnchor), reviewCountLabel.heightAnchor.constraint(equalTo: starRatings.heightAnchor)])
    }
    
    private func configureContainerViewConstraints(){
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([containerView.topAnchor.constraint(equalTo: starRatings.bottomAnchor), containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10), containerView.heightAnchor.constraint(equalToConstant: 45)])
    }
    
    private func configureAboutButtonConstraints(){
        containerView.addSubview(aboutButton)
        aboutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([aboutButton.topAnchor.constraint(equalTo: containerView.topAnchor), aboutButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor), aboutButton.widthAnchor.constraint(equalTo: starRatings.widthAnchor), aboutButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)])
    }
    
    private func configureReviewButtonConstraints(){
        containerView.addSubview(reviewButton)
        reviewButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([reviewButton.topAnchor.constraint(equalTo: containerView.topAnchor), reviewButton.leadingAnchor.constraint(equalTo: reviewCountLabel.leadingAnchor), reviewButton.heightAnchor.constraint(equalTo: aboutButton.heightAnchor), reviewButton.widthAnchor.constraint(equalTo: aboutButton.widthAnchor)])
    }
    
    private func configureHoursOfOperationTextViewConstraints(){
        view.addSubview(hoursOfOperationTextView)
        hoursOfOperationTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([hoursOfOperationTextView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 2), hoursOfOperationTextView.leadingAnchor.constraint(equalTo: addressTextView.leadingAnchor), hoursOfOperationTextView.trailingAnchor.constraint(equalTo: reviewButton.trailingAnchor, constant: 30), hoursOfOperationTextView.heightAnchor.constraint(equalToConstant: 200)])
    }
    
    private func configureNavigateButtomConstraints(){
        view.addSubview(navigateButtom)
        navigateButtom.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([navigateButtom.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -30), navigateButtom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10), navigateButtom.heightAnchor.constraint(equalToConstant: 40), navigateButtom.widthAnchor.constraint(equalToConstant: 120)])
    }
    
}

extension RestaurantDetailViewController: UIScrollViewDelegate{
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        //           pageControl.currentPage = Int(page)
    }
}
