//
//  FoodImagesSellectionCollectionViewCell.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/21/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class FoodImagesSellectionCollectionViewCell: UICollectionViewCell {
    
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
        return label
    }()
    
    lazy var foodColorBadge:UIButton = {
        let view = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.layer.cornerRadius = view.layer.frame.height / 2
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.alpha = 1
        view.backgroundColor = .green
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
    
    
    @objc func handleTap(){
        print("tapped")
    }
    //MARK: Private constraint functions
    
    func createPulse(){
        let position = foodColorBadge.frame.size.width / 2
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 16, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 25.0
        shapeLayer.lineCap = .round
        shapeLayer.position = CGPoint(x: position, y: position)
        //shapeLayer.strokeEnd = 0
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
        NSLayoutConstraint.activate([FoodTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10), FoodTitleLabel.trailingAnchor.constraint(equalTo: self.starRatings.leadingAnchor), FoodTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5), FoodTitleLabel.heightAnchor.constraint(equalToConstant: 25)])
    }
    
    private func configureFoodColorBadgeConstraints(){
        self.addSubview(foodColorBadge)
        foodColorBadge.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([foodColorBadge.topAnchor.constraint(equalTo: self.topAnchor, constant:  10), foodColorBadge.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -10), foodColorBadge.heightAnchor.constraint(equalToConstant: 20), foodColorBadge.widthAnchor.constraint(equalTo: self.foodColorBadge.heightAnchor)])
    }
    
}
