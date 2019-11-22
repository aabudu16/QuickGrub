//
//  FoodImagesSellectionCollectionViewCell.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/21/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class FoodImagesSellectionCollectionViewCell: UICollectionViewCell {
    
    //MARK: UI Objects
    lazy var  foodImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.blue.cgColor
        return image
    }()
    
    lazy var  starRatings:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.blue.cgColor
        return image
    }()
    
    lazy var categoryNameLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.blue.cgColor
        return label
    }()
    
    lazy var FoodTitleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.blue.cgColor
        return label
    }()
    
    //MARK: Lifecycle
    override init (frame:CGRect){
        super.init(frame:frame)
        configureCategoryNameLabelConstraints()
        configureFoodImageConstraints()
        configureStarRatingsConstraints()
        configureFoodTitleConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Private constraint functions
    
    private func configureCategoryNameLabelConstraints(){
        self.addSubview(categoryNameLabel)
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([categoryNameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 2), categoryNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10), categoryNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10), categoryNameLabel.heightAnchor.constraint(equalToConstant: 35)])
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
}
