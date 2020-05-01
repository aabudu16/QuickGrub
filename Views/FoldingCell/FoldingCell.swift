//
//  FoldingCell.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Kingfisher

// UITableViewCell with folding animation
open class FoldingCell: UITableViewCell {
    
    weak var delegate: FoldingCellDelegate?
    var foregroundViewTop:NSLayoutConstraint!
    var containerViewTop:NSLayoutConstraint!
    var animationView: UIView?
    var animationItemViews: [RotatedView]?
    @objc open var isUnfolded = false
    
    //  the number of folding elements. Default 2
    @IBInspectable open var itemCount: NSInteger = 4
    
    // The color of the back cell
    @IBInspectable open var backViewColor: UIColor = UIColor.lightGray
    
    // UIView whitch display when cell is open
    lazy var containerView:UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.isUserInteractionEnabled = true
        return container
    }()
    
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
    
    lazy var resturantName:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Avenir-Heavy", size: 23)
        return label
    }()
    
    lazy var addressTextView:UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.textAlignment = .left
        tv.dataDetectorTypes = [.address]
        tv.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
        tv.adjustsFontForContentSizeCategory = false
        tv.isUserInteractionEnabled = false
        tv.font = UIFont(name: "Avenir-Light", size: 19)
        return tv
    }()
    
    lazy var openOrCloseLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 18)
        label.textAlignment = .center
        return label
    }()
    
    lazy var resturantPhoneNumber:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Light", size: 20)
        return label
    }()
    
    lazy var moreDetailButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.addTarget(self, action: #selector(handleMoreButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var navigateButtom:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "navigate"), for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        button.layer.shadowRadius = 20.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        return button
    }()
    
    lazy var mapView:MKMapView = {
        let map = MKMapView()
        map.delegate = self
        map.isScrollEnabled = false
        return map
    }()
    
    lazy var heartImage:UIButton = {
        let heart = UIButton()
        heart.contentMode = .scaleToFill
        heart.setImage(UIImage(systemName: "heart")?.withTintColor(.white), for: .normal)
        heart.addTarget(self, action: #selector(handleFavoriteButtonPressed), for: .touchUpInside)
        return heart
    }()
    
    // UIView whitch display when cell close
    lazy var foregroundView:RotatedView! = {
        let foreground = RotatedView()
        foreground.backgroundColor = .white
        foreground.layer.cornerRadius = 10
        foreground.layer.masksToBounds = true
        return foreground
    }()
    
    lazy var resturantNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DamascusBold", size: 20)
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 1.0
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy  var distanceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Medium 18.0", size: 18)
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 1.0
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var foodImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private func zoomToLatestLocation(with coordinate:CLLocationCoordinate2D){
        let zoomRegion = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    public func configureBusinessData(business:CDYelpBusiness, distance:CDYelpBusiness){
        let image = UIImage(named: "FoodPlaceholder")
        foodImageView.kf.indicatorType = .activity
        foodImageView.kf.setImage(with: business.imageUrl, placeholder: image, options: [.transition(.fade(0.2))])
        
        if let businessAddress = business.location?.displayAddress {
            if businessAddress.count > 1 {
                addressTextView.text = "\(businessAddress[0]) \(businessAddress[1])"
            } else {
                addressTextView.text = "\(businessAddress.first ?? "")"
            }
        }
        
        resturantPhoneNumber.text = business.displayPhone
        distanceLabel.text = "📍 \(Int(distance.distance ?? 0.0)) mi"
        resturantName.text = business.name
        resturantNameLabel.text = business.name
        
        openOrCloseLabel.text = business.isClosed == true ? "Close" : "Open"
        openOrCloseLabel.textColor = business.isClosed == true ?  #colorLiteral(red: 0.8425863981, green: 0.1913244128, blue: 0.1395176649, alpha: 1) : #colorLiteral(red: 0.09106949717, green: 0.5007923841, blue: 0.2231527567, alpha: 1)
        
        addImageToScrollView(business: business, placeHolderImage: image!)
        //MARK: - Adds annotation to mapview
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: business.coordinates?.latitude ?? 40.6782, longitude: business.coordinates?.longitude ?? -73.9442)
        self.mapView.addAnnotation(annotation)
        zoomToLatestLocation(with: annotation.coordinate)
        
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        durationsForExpandedState = durations
        durationsForCollapsedState = durations
    }
    /**
     Folding animation types
     
     - Open:  Open direction
     - Close: Close direction
     */
    @objc public enum AnimationType : Int {
        case open
        case close
    }
    
    // MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        configureForegroundViewConstraints()
        configureContainerViewConstraints()
        configureResturantImageConstraint()
        configureResturantNameLabelConstraints()
        configureDistanceLabelConstraints()
        
        configureImageScrollViewConstraints()
        configurePageControlConstraints()
        configureHeartImageConstraints()
        configureMapViewConstraints()
        configureNavigateButtomConstraints()
        configureResturantNameConstraints()
        configureAddressTextViewConstraints()
        configureResturantPhoneNumberConstraints()
        configureOpenOrCloseLabelConstraints()
        configureMoreDetailButtonConstraints()
        commonInit()
        imageScrollView.delegate = self
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: -- @objc Function
    @objc func handleMoreButtonPressed(sender:UIButton){
        delegate?.navigateToDetailedViewController(tag: sender.tag)
    }
    
    @objc private func getDirections(sender:UIButton) {
        delegate?.navigateToDestination(tag: sender.tag)
    }
    
    @objc func handleFavoriteButtonPressed(sender:UIButton){
        delegate?.handleFavorite(tag: sender.tag)
    }
    
    @objc open func commonInit() {
        configureDefaultState()
        
        selectionStyle = .none
        containerView.layer.cornerRadius = foregroundView.layer.cornerRadius
        containerView.layer.masksToBounds = true
    }
    
    // MARK: configure
    private func addImageToScrollView(business:CDYelpBusiness, placeHolderImage:UIImage){
        if let photoArray = business.photos{
            for (index, photoString) in photoArray.enumerated(){
                pageControl.numberOfPages = photoArray.count
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill
                let imageUrl = URL(string: photoString)
                DispatchQueue.main.async {
                    imageView.kf.setImage(with: imageUrl, placeholder: placeHolderImage, options: [.transition(.fade(0.2))])
                    imageView.setNeedsDisplay()
                    let xPosition:CGFloat = self.containerView.frame.width * CGFloat(index)
                    imageView.frame = CGRect(x: xPosition, y: 0, width: self.imageScrollView.frame.width, height: self.imageScrollView.frame.height)
                    
                    self.imageScrollView.contentSize.width = self.imageScrollView.frame.width * CGFloat(index + 1)
                    self.imageScrollView.addSubview(imageView)
                }
                
            }
        }
    }
    
    private func configureDefaultState() {
        guard let foregroundViewTop = self.foregroundViewTop,
            let containerViewTop = self.containerViewTop else {return}
        
        containerViewTop.constant = foregroundViewTop.constant
        containerView.alpha = 0
        
        if let height = (foregroundView.constraints.filter { $0.firstAttribute == .height && $0.secondItem == nil }).first?.constant {
            foregroundView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
            foregroundViewTop.constant += height / 2
        }
        foregroundView.layer.transform = foregroundView.transform3d()
        
        createAnimationView()
        contentView.bringSubviewToFront(foregroundView)
    }
    
    private func createAnimationItemView() -> [RotatedView] {
        var items = [RotatedView]()
        items.append(foregroundView)
        var rotatedViews = [RotatedView]()
        animationView?.subviews
            .lazy
            .compactMap({ $0 as? RotatedView })
            .sorted(by: { $0.tag < $1.tag })
            .forEach { itemView in
                rotatedViews.append(itemView)
                if let backView = itemView.backView {
                    rotatedViews.append(backView)
                }
        }
        items.append(contentsOf: rotatedViews)
        return items
    }
    
    func configureAnimationItems(_ animationType: AnimationType) {
        if animationType == .open {
            animationView?.subviews
                .lazy
                .compactMap { $0 as? RotatedView }
                .forEach { $0.alpha = 0 }
        } else {
            animationView?.subviews
                .lazy
                .compactMap { $0 as? RotatedView }
                .forEach {
                    $0.alpha = animationType == .open ? 0 : 1
                    if animationType != .open { $0.backView?.alpha = 0 }
            }
        }
    }
    
    func createAnimationView() {
        animationView = UIView(frame: containerView.frame)
        animationView?.layer.cornerRadius = foregroundView.layer.cornerRadius
        animationView?.backgroundColor = .clear
        animationView?.translatesAutoresizingMaskIntoConstraints = false
        animationView?.alpha = 0
        
        guard let animationView = self.animationView else { return }
        
        self.contentView.addSubview(animationView)
        
        // copy constraints from containerView
        var newConstraints = [NSLayoutConstraint]()
        for constraint in self.contentView.constraints {
            if let item = constraint.firstItem as? UIView, item == containerView {
                let newConstraint = NSLayoutConstraint(item: animationView, attribute: constraint.firstAttribute,
                                                       relatedBy: constraint.relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute,
                                                       multiplier: constraint.multiplier, constant: constraint.constant)
                
                newConstraints.append(newConstraint)
            } else if let firstItem = constraint.firstItem as? UIView, let secondItem: UIView = constraint.secondItem as? UIView, secondItem == containerView {
                let newConstraint = NSLayoutConstraint(item: firstItem, attribute: constraint.firstAttribute,
                                                       relatedBy: constraint.relation, toItem: animationView, attribute: constraint.secondAttribute,
                                                       multiplier: constraint.multiplier, constant: constraint.constant)
                
                newConstraints.append(newConstraint)
            }
        }
        self.contentView.addConstraints(newConstraints)
        
        for constraint in containerView.constraints { // added height constraint
            if constraint.firstAttribute == .height, let item: UIView = constraint.firstItem as? UIView, item == containerView {
                let newConstraint = NSLayoutConstraint(item: animationView, attribute: constraint.firstAttribute,
                                                       relatedBy: constraint.relation, toItem: nil, attribute: constraint.secondAttribute,
                                                       multiplier: constraint.multiplier, constant: constraint.constant)
                
                animationView.addConstraint(newConstraint)
            }
        }
    }
    
    func addImageItemsToAnimationView() {
        containerView.alpha = 1
        let containerViewSize = containerView.bounds.size
        let foregroundViewSize = foregroundView.bounds.size
        
        // added first item
        var image = containerView.takeSnapshot(CGRect(x: 0, y: 0, width: containerViewSize.width, height: foregroundViewSize.height))
        var imageView = UIImageView(image: image)
        imageView.tag = 0
        imageView.layer.cornerRadius = foregroundView.layer.cornerRadius
        animationView?.addSubview(imageView)
        
        // added secod item
        image = containerView.takeSnapshot(CGRect(x: 0, y: foregroundViewSize.height, width: containerViewSize.width, height: foregroundViewSize.height))
        
        imageView = UIImageView(image: image)
        let rotatedView = RotatedView(frame: imageView.frame)
        rotatedView.tag = 1
        rotatedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        rotatedView.layer.transform = rotatedView.transform3d()
        
        rotatedView.addSubview(imageView)
        animationView?.addSubview(rotatedView)
        rotatedView.frame = CGRect(x: imageView.frame.origin.x, y: foregroundViewSize.height, width: containerViewSize.width, height: foregroundViewSize.height)
        
        // added other views
        let itemHeight = (containerViewSize.height - 2 * foregroundViewSize.height) / CGFloat(itemCount - 2)
        
        if itemCount == 2 {
            // decrease containerView height or increase itemCount
            assert(containerViewSize.height - 2 * foregroundViewSize.height == 0, "contanerView.height too high")
        } else {
            // decrease containerView height or increase itemCount
            assert(containerViewSize.height - 2 * foregroundViewSize.height >= itemHeight, "contanerView.height too high")
        }
        
        var yPosition = 2 * foregroundViewSize.height
        var tag = 2
        for _ in 2 ..< itemCount {
            image = containerView.takeSnapshot(CGRect(x: 0, y: yPosition, width: containerViewSize.width, height: itemHeight))
            
            imageView = UIImageView(image: image)
            let rotatedView = RotatedView(frame: imageView.frame)
            
            rotatedView.addSubview(imageView)
            rotatedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            rotatedView.layer.transform = rotatedView.transform3d()
            animationView?.addSubview(rotatedView)
            rotatedView.frame = CGRect(x: 0, y: yPosition, width: rotatedView.bounds.size.width, height: itemHeight)
            rotatedView.tag = tag
            
            yPosition += itemHeight
            tag += 1
        }
        
        containerView.alpha = 0
        
        if let animationView = self.animationView {
            // added back view
            var previuosView: RotatedView?
            for case let container as RotatedView in animationView.subviews.sorted(by: { $0.tag < $1.tag })
                where container.tag > 0 && container.tag < animationView.subviews.count {
                    previuosView?.addBackView(container.bounds.size.height, color: backViewColor)
                    previuosView = container
            }
        }
        animationItemViews = createAnimationItemView()
    }
    
    fileprivate func removeImageItemsFromAnimationView() {
        guard let animationView = self.animationView else {
            return
        }
        
        animationView.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    // MARK: public
    
    /// Unfold cell.
    ///
    /// - Parameters:
    ///   - value: unfold = true; collapse = false.
    ///   - animated: animate changes.
    ///   - completion: A block object to be executed when the animation sequence ends.
    @objc open func unfold(_ value: Bool, animated: Bool = true, completion: (() -> Void)? = nil) {
        if animated {
            value ? openAnimation(completion) : closeAnimation(completion)
        } else {
            foregroundView.alpha = value ? 0 : 1
            containerView.alpha = value ? 1 : 0
        }
    }
    
    @objc open func isAnimating() -> Bool {
        return animationView?.alpha == 1 ? true : false
    }
}

// Helper function inserted by Swift 4.2 migrator.
 func convertFromCAMediaTimingFunctionName(_ input: CAMediaTimingFunctionName) -> String {
    return input.rawValue
}

