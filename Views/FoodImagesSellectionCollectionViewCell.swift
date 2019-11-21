//
//  FoodImagesSellectionCollectionViewCell.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/21/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class FoodImagesSellectionCollectionViewCell: UICollectionViewCell {
    
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
    
    override init (frame:CGRect){
        super.init(frame:frame)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
