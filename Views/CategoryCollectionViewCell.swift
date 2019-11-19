//
//  CategoryCollectionViewCell.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    lazy var checkMarkButton:UIButton = {
       let button = UIButton()
        return button
    }()
    
    lazy var catrgoryLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: "")
        return label
    }()
    
    lazy var categoryImage:UIImageView = {
    let image = UIImageView()
        return image
    }()
    
    override init (frame:CGRect){
           super.init(frame:frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

