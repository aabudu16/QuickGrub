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
        return image
    }()
    
    lazy var  ratimgs:UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var categoryNameLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var FoodTitleLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    //MARK: Lifecycle
    override init (frame:CGRect){
        super.init(frame:frame)
       configureFoodImageConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureFoodImageConstraints(){
        self.addSubview(foodImage)
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([foodImage.topAnchor.constraint(equalTo: self.topAnchor), foodImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10), foodImage.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10), foodImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
}
