//
//  FoodImagesSellectionCollectionViewCell.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/21/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import Kingfisher

class FoodImagesSelectionCollectionViewCell: UICollectionViewCell { 
    weak var delegate: CollectionViewCellDelegate?
    var shortCutViewTopAnchor:NSLayoutConstraint?
    var newShortCutViewTopAnchor:NSLayoutConstraint?
    
    let plus = UIImage(systemName: "plus")
    let checkmark = UIImage(systemName: "checkmark")
    
    var itemIsSelected:Bool = false {
        didSet{
            self.itemIsSelected == true ? addItemButton.setImage( checkmark, for: .normal) : addItemButton.setImage( plus, for: .normal)
        }
    }
    
    let shapeLayer = CAShapeLayer()
    //MARK: UI Objects
    lazy var  foodImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var  starRatings:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var categoryNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Verdana-Bold", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var FoodTitleLabel:UILabel = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGetstureDetected))
        tapGesture.numberOfTapsRequired = 2
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    lazy var addItemButton:UIButton = {
        let view = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.setImage(UIImage(systemName: "plus"), for: .normal)
        view.tintColor = .white
        view.layer.cornerRadius = view.layer.frame.height / 2
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.alpha = 1
        view.backgroundColor = #colorLiteral(red: 0.01854561083, green: 0.8099911809, blue: 0.6765680909, alpha: 1)
        view.addTarget(self, action: #selector(handleFoodColorBadgePressed(sender:)), for: .touchUpInside)
        return view
    }()
    
    lazy var shortCutView:UIView = {
        let tv = UIView(frame: UIScreen.main.bounds)
        tv.blurView.setup(style: UIBlurEffect.Style.dark, alpha: 0.6).enable()
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    lazy var logoImage:UIImageView = {
        let logo = UIImageView()
        logo.layer.borderColor = UIColor.blue.cgColor
        logo.layer.borderWidth = 2
        logo.image = UIImage(named: "foodBadge")
        return logo
    }()
    
    //MARK: Lifecycle
    override init (frame:CGRect){
        super.init(frame:frame)
        configureCategoryNameLabelConstraints()
        configureFoodImageConstraints()
        configureStarRatingsConstraints()
        configureFoodTitleConstraints()
        configureAddItemButtonConstraints()
        configureShortCutViewViewConstraints()
        configureLogoImageConstraints()
        createPulse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-- Public Functions
    public func configurefoodImagesCellData(yelpImages:CDYelpBusiness){
        var categoryList:String = ""
        
        let image = UIImage(named: "FoodPlaceholder")
        foodImage.kf.indicatorType = .activity
        foodImage.kf.setImage(with: yelpImages.imageUrl, placeholder: image, options: [.transition(.fade(0.2))])
        
        switch yelpImages.rating{
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
        
        categoryNameLabel.text = yelpImages.categories![0].title
        FoodTitleLabel.text = yelpImages.name
        
        for category in yelpImages.categories!{
            if let category = category.title{
                categoryList += "\(category) "
            }
        }
        
        CustomLayer.shared.createCustomlayers(layer: layer, cornerRadius: 2, backgroundColor: UIColor.white.cgColor)
        layer.cornerRadius = 25
    }
    
    
    //MARK:-- @objc functions
    
    // MARK: Handle Gesture detection
    
    @objc func tapGetstureDetected(sender:UITapGestureRecognizer) {
        delegate?.handleShortCut(tag: sender.view!.tag)
    }
    
    @objc func handleFoodColorBadgePressed(sender:UIButton){
        delegate?.addSelectedFood(tag: sender.tag)
    }
    
    //MARK:-- fuctions
    
    func createPulse(){
        let position = addItemButton.frame.size.width / 2
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 16, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.01854561083, green: 0.8099911809, blue: 0.6765680909, alpha: 1)
        shapeLayer.fillColor = #colorLiteral(red: 0.01854561083, green: 0.8099911809, blue: 0.6765680909, alpha: 1)
        shapeLayer.lineWidth = 40.0
        shapeLayer.lineCap = .round
        shapeLayer.position = CGPoint(x: position, y: position)
        addItemButton.layer.addSublayer(shapeLayer)
        animatePulse()
    }
    
    func animatePulse(){
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 2.0
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        shapeLayer.add(scaleAnimation, forKey: "scale")
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.duration = 2.0
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        shapeLayer.add(opacityAnimation, forKey: "opacity")
    }
    
    
    //MARK: Private constraint functions
    private func configureCategoryNameLabelConstraints(){
        self.addSubview(categoryNameLabel)
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([categoryNameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 6), categoryNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10), categoryNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100), categoryNameLabel.heightAnchor.constraint(equalToConstant: 35)])
    }
    
    private func configureFoodImageConstraints(){
        self.addSubview(foodImage)
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([foodImage.topAnchor.constraint(equalTo: self.topAnchor, constant:  40), foodImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0), foodImage.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 0), foodImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -60)])
    }
    
    private func configureStarRatingsConstraints(){
        self.addSubview(starRatings)
        starRatings.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([starRatings.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -15), starRatings.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5), starRatings.heightAnchor.constraint(equalToConstant: 25), starRatings.widthAnchor.constraint(equalToConstant: 80)])
    }
    
    private func configureFoodTitleConstraints(){
        self.addSubview(FoodTitleLabel)
        FoodTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([FoodTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10), FoodTitleLabel.trailingAnchor.constraint(equalTo: self.starRatings.leadingAnchor), FoodTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5), FoodTitleLabel.topAnchor.constraint(equalTo: foodImage.bottomAnchor)])
    }
    
    private func configureAddItemButtonConstraints(){
        self.addSubview(addItemButton)
        addItemButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([addItemButton.topAnchor.constraint(equalTo: self.topAnchor, constant:  5), addItemButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -10), addItemButton.heightAnchor.constraint(equalToConstant: 30), addItemButton.widthAnchor.constraint(equalTo: self.addItemButton.heightAnchor)])
    }
    
    private func configureShortCutViewViewConstraints(){
        foodImage.addSubview(shortCutView)
        shortCutView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([shortCutView.leadingAnchor.constraint(equalTo: foodImage.leadingAnchor), shortCutView.trailingAnchor.constraint(equalTo: foodImage.trailingAnchor), shortCutView.bottomAnchor.constraint(equalTo: foodImage.bottomAnchor)])
        
        shortCutViewTopAnchor = shortCutView.topAnchor.constraint(equalTo: foodImage.bottomAnchor)
        shortCutViewTopAnchor?.isActive = true
        
        newShortCutViewTopAnchor = shortCutView.topAnchor.constraint(equalTo: foodImage.topAnchor)
        newShortCutViewTopAnchor?.isActive = false
    }
    
    private func configureLogoImageConstraints(){
        shortCutView.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([logoImage.topAnchor.constraint(equalTo: shortCutView.topAnchor), logoImage.centerXAnchor.constraint(equalTo: shortCutView.centerXAnchor), logoImage.heightAnchor.constraint(equalToConstant: 60), logoImage.widthAnchor.constraint(equalToConstant: 60)])
    }
    
}
