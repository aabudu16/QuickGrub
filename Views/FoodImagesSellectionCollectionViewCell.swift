//
//  FoodImagesSellectionCollectionViewCell.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/21/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import Kingfisher

protocol CollectionViewCellDelegate: AnyObject {
    func addSelectedFood(tag: Int)
}

class FoodImagesSellectionCollectionViewCell: UICollectionViewCell {
    weak var delegate: CollectionViewCellDelegate?
    
    let plus = UIImage(systemName: "plus")
    let checkmark = UIImage(systemName: "checkmark")
    
       var itemIsSelected:Bool = false {
        didSet{
            self.itemIsSelected == true ? foodColorBadge.setImage( checkmark, for: .normal) : foodColorBadge.setImage( plus, for: .normal)
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
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    lazy var foodColorBadge:UIButton = {
        let view = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.setImage(UIImage(systemName: "plus")?.withTintColor(.white), for: .normal)
        view.layer.cornerRadius = view.layer.frame.height / 2
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.alpha = 1
        view.backgroundColor = .blue
        view.addTarget(self, action: #selector(handleFoodColorBadgePressed(sender:)), for: .touchUpInside)
        return view
    }()
    
    //MARK: Lifecycle
    override init (frame:CGRect){
        super.init(frame:frame)
        configureCategoryNameLabelConstraints()
        configureFoodImageConstraints()
        configureStarRatingsConstraints()
        configureFoodTitleConstraints()
        configureFoodColorBadgeConstraints()
        
        
        createPulse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        categoryNameLabel.text = categoryList
               FoodTitleLabel.text = yelpImages.name
        
        for category in yelpImages.categories!{
            if let category = category.title{
                categoryList += "\(category) "
            }
        }
        
        CustomLayer.shared.createCustomlayers(layer: layer, cornerRadius: 2, backgroundColor: UIColor.white.cgColor)
        layer.cornerRadius = 25
    }
    
    
    @objc func handleFoodColorBadgePressed(sender:UIButton){
        delegate?.addSelectedFood(tag: sender.tag)
    }
    
    func createPulse(){
        let position = foodColorBadge.frame.size.width / 2
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 16, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 40.0
        shapeLayer.lineCap = .round
        shapeLayer.position = CGPoint(x: position, y: position)
        foodColorBadge.layer.addSublayer(shapeLayer)
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
    
    private func configureFoodColorBadgeConstraints(){
        self.addSubview(foodColorBadge)
        foodColorBadge.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([foodColorBadge.topAnchor.constraint(equalTo: self.topAnchor, constant:  5), foodColorBadge.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -10), foodColorBadge.heightAnchor.constraint(equalToConstant: 30), foodColorBadge.widthAnchor.constraint(equalTo: self.foodColorBadge.heightAnchor)])
    }
    
}
