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

// UITableViewCell with folding animation
open class FoldingCell: UITableViewCell {
    
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
    
    lazy var resturantImageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "resturant")
        return image
    }()
    
    lazy var resturantName:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Heavy", size: 23)
        label.text = "Pasteles Del Caribe"
        return label
    }()
    
    lazy var addressTextView:UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.textAlignment = .left
        tv.adjustsFontForContentSizeCategory = false
        tv.isUserInteractionEnabled = false
        tv.text = "218-28 Merrick Blvd, Springfield Gardens, NY 11413"
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
        return button
    }()
    
    lazy var navigateButtom:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = .black
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        button.layer.shadowRadius = 20.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        return button
    }()
    
    lazy var mapView:MKMapView = {
        let map = MKMapView()
        map.delegate = self
        map.userTrackingMode = .followWithHeading
        return map
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
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy  var distanceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Medium 18.0", size: 18)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var foodImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    
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
        
        configureResurantImageViewConstraints()
        configureMapViewConstraints()
        configureNavigateButtomConstraints()
        configureResturantNameConstraints()
        configureAddressTextViewConstraints()
        configureResturantPhoneNumberConstraints()
        configureOpenOrCloseLabelConstraints()
        configureMoreDetailButtonConstraints()
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Call this method in methods init(style: UITableViewCellStyle, reuseIdentifier: String?) after creating Views
     */
    @objc open func commonInit() {
        configureDefaultState()
        
        selectionStyle = .none
        
        containerView.layer.cornerRadius = foregroundView.layer.cornerRadius
        containerView.layer.masksToBounds = true
    }
    
    // MARK: configure
    
    private func configureDefaultState() {
        
        guard let foregroundViewTop = self.foregroundViewTop,
            let containerViewTop = self.containerViewTop else {
                fatalError("set foregroundViewTop or containerViewTop outlets in storyboard")
        }
        
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
    
    // MARK: Animations
    
    @objc open dynamic func animationDuration(_ itemIndex: NSInteger, type: AnimationType) -> TimeInterval {
        return type == .close ? durationsForCollapsedState[itemIndex] : durationsForExpandedState[itemIndex]
    }
    
    @objc open var durationsForExpandedState: [TimeInterval] = []
    @objc open var durationsForCollapsedState: [TimeInterval] = []
    
    func durationSequence(_ type: AnimationType) -> [TimeInterval] {
        var durations = [TimeInterval]()
        for i in 0 ..< itemCount - 1 {
            let duration = animationDuration(i, type: type)
            durations.append(TimeInterval(duration / 2.0))
            durations.append(TimeInterval(duration / 2.0))
        }
        return durations
    }
    
    func openAnimation(_ completion: (() -> Void)?) {
        isUnfolded = true
        removeImageItemsFromAnimationView()
        addImageItemsToAnimationView()
        
        animationView?.alpha = 1
        containerView.alpha = 0
        
        let durations = durationSequence(.open)
        
        var delay: TimeInterval = 0
        var timing = convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeIn)
        var from: CGFloat = 0.0
        var to: CGFloat = -CGFloat.pi / 2
        var hidden = true
        configureAnimationItems(.open)
        
        guard let animationItemViews = self.animationItemViews else {
            return
        }
        
        for index in 0 ..< animationItemViews.count {
            let animatedView = animationItemViews[index]
            
            animatedView.foldingAnimation(timing, from: from, to: to, duration: durations[index], delay: delay, hidden: hidden)
            
            from = from == 0.0 ? CGFloat.pi / 2 : 0.0
            to = to == 0.0 ? -CGFloat.pi / 2 : 0.0
            timing = timing == convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeIn) ? convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeOut) : convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeIn)
            hidden = !hidden
            delay += durations[index]
        }
        
        let firstItemView = animationView?.subviews.filter { $0.tag == 0 }.first
        
        firstItemView?.layer.masksToBounds = true
        DispatchQueue.main.asyncAfter(deadline: .now() + durations[0], execute: {
            firstItemView?.layer.cornerRadius = 0
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.animationView?.alpha = 0
            self.containerView.alpha = 1
            completion?()
        }
    }
    
    func closeAnimation(_ completion: (() -> Void)?) {
        isUnfolded = false
        removeImageItemsFromAnimationView()
        addImageItemsToAnimationView()
        
        guard let animationItemViews = self.animationItemViews else {
            fatalError()
        }
        
        animationView?.alpha = 1
        containerView.alpha = 0
        
        let durations: [TimeInterval] = durationSequence(.close).reversed()
        
        var delay: TimeInterval = 0
        var timing = convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeIn)
        var from: CGFloat = 0.0
        var to: CGFloat = CGFloat.pi / 2
        var hidden = true
        configureAnimationItems(.close)
        
        if durations.count < animationItemViews.count {
            fatalError("wrong override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval")
        }
        for index in 0 ..< animationItemViews.count {
            let animatedView = animationItemViews.reversed()[index]
            
            animatedView.foldingAnimation(timing, from: from, to: to, duration: durations[index], delay: delay, hidden: hidden)
            
            to = to == 0.0 ? CGFloat.pi / 2 : 0.0
            from = from == 0.0 ? -CGFloat.pi / 2 : 0.0
            timing = timing == convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeIn) ? convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeOut) : convertFromCAMediaTimingFunctionName(CAMediaTimingFunctionName.easeIn)
            hidden = !hidden
            delay += durations[index]
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            self.animationView?.alpha = 0
            completion?()
        })
        
        let firstItemView = animationView?.subviews.filter { $0.tag == 0 }.first
        firstItemView?.layer.cornerRadius = 0
        firstItemView?.layer.masksToBounds = true
        if let durationFirst = durations.first {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay - durationFirst * 2, execute: {
                firstItemView?.layer.cornerRadius = self.foregroundView.layer.cornerRadius
                firstItemView?.setNeedsDisplay()
                firstItemView?.setNeedsLayout()
            })
        }
    }
    
    
    //MARK: Constraints
    func configureForegroundViewConstraints(){
        self.addSubview(foregroundView)
        foregroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([ foregroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8), foregroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8), foregroundView.heightAnchor.constraint(equalToConstant:170)])
        
        foregroundViewTop = foregroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        foregroundViewTop.isActive = true
        
    }
    
    func configureContainerViewConstraints(){
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8), containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8), containerView.heightAnchor.constraint(equalToConstant:CGFloat(120 * itemCount))])
        
        containerViewTop = containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 97)
        containerViewTop.isActive = true
    }
    
    private func configureResturantImageConstraint(){
        self.foregroundView.addSubview(foodImageView)
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([foodImageView.bottomAnchor.constraint(equalTo: self.foregroundView.bottomAnchor, constant:  -30), foodImageView.leadingAnchor.constraint(equalTo: self.foregroundView.leadingAnchor), foodImageView.trailingAnchor.constraint(equalTo: self.foregroundView.trailingAnchor), foodImageView.topAnchor.constraint(equalTo: foregroundView.topAnchor)])
    }
    
    private func configureResturantNameLabelConstraints(){
        self.foregroundView.addSubview(resturantNameLabel)
        resturantNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resturantNameLabel.bottomAnchor.constraint(equalTo: self.foregroundView.bottomAnchor), resturantNameLabel.leadingAnchor.constraint(equalTo: self.foregroundView.leadingAnchor, constant: 5), resturantNameLabel.trailingAnchor.constraint(equalTo: self.foregroundView.trailingAnchor, constant: -100), resturantNameLabel.topAnchor.constraint(equalTo: self.foodImageView.bottomAnchor)])
    }
    
    private func configureDistanceLabelConstraints(){
        foregroundView.addSubview(distanceLabel)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([distanceLabel.bottomAnchor.constraint(equalTo: self.foregroundView.bottomAnchor), distanceLabel.trailingAnchor.constraint(equalTo: self.foregroundView.trailingAnchor, constant: -2), distanceLabel.leadingAnchor.constraint(equalTo: resturantNameLabel.trailingAnchor), distanceLabel.topAnchor.constraint(equalTo: self.foodImageView.bottomAnchor)])
    }
    
    private func configureResurantImageViewConstraints(){
        containerView.addSubview(resturantImageView)
        resturantImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resturantImageView.topAnchor.constraint(equalTo: containerView.topAnchor),resturantImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),resturantImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),resturantImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -280)])
    }
    
    private func configureResturantNameConstraints(){
        containerView.addSubview(resturantName)
        resturantName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resturantName.topAnchor.constraint(equalTo: resturantImageView.bottomAnchor, constant: 3), resturantName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 3), resturantName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -3), resturantName.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func configureAddressTextViewConstraints(){
        containerView.addSubview(addressTextView)
        addressTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([addressTextView.topAnchor.constraint(equalTo: resturantName.bottomAnchor),addressTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 3),addressTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -100), addressTextView.heightAnchor.constraint(equalToConstant: 90)])
    }
    
    private func configureResturantPhoneNumberConstraints(){
        containerView.addSubview(resturantPhoneNumber)
        resturantPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resturantPhoneNumber.topAnchor.constraint(equalTo: addressTextView.bottomAnchor,constant: 3),resturantPhoneNumber.leadingAnchor.constraint(equalTo: addressTextView.leadingAnchor),resturantPhoneNumber.trailingAnchor.constraint(equalTo: addressTextView.trailingAnchor), resturantPhoneNumber.bottomAnchor.constraint(equalTo: mapView.topAnchor, constant: -3)])
    }
    
    private func configureOpenOrCloseLabelConstraints(){
        containerView.addSubview(openOrCloseLabel)
        openOrCloseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([openOrCloseLabel.topAnchor.constraint(equalTo: resturantName.bottomAnchor), openOrCloseLabel.trailingAnchor.constraint(equalTo: resturantName.trailingAnchor), openOrCloseLabel.leadingAnchor.constraint(equalTo: addressTextView.trailingAnchor, constant: 3), openOrCloseLabel.heightAnchor.constraint(equalTo: resturantName.heightAnchor)])
    }
    
    private func configureMoreDetailButtonConstraints(){
        containerView.addSubview(moreDetailButton)
        moreDetailButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([moreDetailButton.topAnchor.constraint(equalTo: openOrCloseLabel.bottomAnchor,constant: 5), moreDetailButton.trailingAnchor.constraint(equalTo: openOrCloseLabel.trailingAnchor), moreDetailButton.leadingAnchor.constraint(equalTo: openOrCloseLabel.leadingAnchor), moreDetailButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func configureMapViewConstraints(){
        containerView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([mapView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),mapView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),mapView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor), mapView.heightAnchor.constraint(equalToConstant: 90)])
    }
    
    private func configureNavigateButtomConstraints(){
        mapView.addSubview(navigateButtom)
        navigateButtom.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([navigateButtom.topAnchor.constraint(equalTo: mapView.topAnchor,constant: 20), navigateButtom.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10), navigateButtom.heightAnchor.constraint(equalToConstant: 40), navigateButtom.widthAnchor.constraint(equalTo: navigateButtom.heightAnchor)])
    }
    
}

extension FoldingCell: MKMapViewDelegate{
    // Do something here with maps
}

// MARK: RotatedView

open class RotatedView: UIView {
    
    private enum Const {
        static let rotationX = "rotation.x"
        static let transformRotationX = "transform.rotation.x"
    }
    
    var hiddenAfterAnimation = false
    var backView: RotatedView?
    
    func addBackView(_ height: CGFloat, color: UIColor) {
        let view = RotatedView(frame: CGRect.zero)
        view.backgroundColor = color
        view.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        view.layer.transform = view.transform3d()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        backView = view
        
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: height))
        self.addConstraints([ NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: self.bounds.size.height - height + height / 2), NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
                              
            NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)])
    }
}

extension RotatedView: CAAnimationDelegate {
    
    func rotatedX(_ angle: CGFloat) {
        var allTransofrom = CATransform3DIdentity
        let rotateTransform = CATransform3DMakeRotation(angle, 1, 0, 0)
        allTransofrom = CATransform3DConcat(allTransofrom, rotateTransform)
        allTransofrom = CATransform3DConcat(allTransofrom, transform3d())
        self.layer.transform = allTransofrom
    }
    
    func transform3d() -> CATransform3D {
        var transform = CATransform3DIdentity
        transform.m34 = 2.5 / -2000
        return transform
    }
    
    // MARK: animations
    
    func foldingAnimation(_ timing: String, from: CGFloat, to: CGFloat, duration: TimeInterval, delay: TimeInterval, hidden: Bool) {
        
        let rotateAnimation = CABasicAnimation(keyPath: Const.transformRotationX)
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: convertToCAMediaTimingFunctionName(timing))
        rotateAnimation.fromValue = from
        rotateAnimation.toValue = to
        rotateAnimation.duration = duration
        rotateAnimation.delegate = self
        rotateAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.beginTime = CACurrentMediaTime() + delay
        
        self.hiddenAfterAnimation = hidden
        
        self.layer.add(rotateAnimation, forKey: Const.rotationX)
    }
    
    public func animationDidStart(_: CAAnimation) {
        self.layer.shouldRasterize = true
        self.alpha = 1
    }
    
    public func animationDidStop(_: CAAnimation, finished _: Bool) {
        if hiddenAfterAnimation {
            self.alpha = 0
        }
        self.layer.removeAllAnimations()
        self.layer.shouldRasterize = false
        self.rotatedX(CGFloat(0))
    }
}

// MARK: UIView + extension
private extension UIView {
    
    func takeSnapshot(_ frame: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.translateBy(x: frame.origin.x * -1, y: frame.origin.y * -1)
        
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCAMediaTimingFunctionName(_ input: CAMediaTimingFunctionName) -> String {
    return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToCAMediaTimingFunctionName(_ input: String) -> CAMediaTimingFunctionName {
    return CAMediaTimingFunctionName(rawValue: input)
}

