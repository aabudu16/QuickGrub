//
//  CategoryCollectionViewCell.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
 
    private enum CellState {
        case selected
        case deselected
        
        var change: CellState {
            switch self {
            case .selected: return .deselected
            case .deselected: return .selected
            }
        }
    }
    
    
    //MARK: UI Objects
    lazy var checkMarkButton:UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var categoryLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: "sonething new")
        return label
    }()
    
    lazy var categoryImage:UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var  selectedView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = view.frame.height / 2
        return view
    }()
    
    //MARK: Lifecycle
    override init (frame:CGRect){
        super.init(frame:frame)
        configureCategoryImageConstraints()
        configureCategoryLabelConstraints()
        configureSelectedViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private constraints
    
    private func configureCategoryImageConstraints(){
        self.addSubview(categoryImage)
        categoryImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([categoryImage.topAnchor.constraint(equalTo: self.topAnchor), categoryImage.leadingAnchor.constraint(equalTo: self.leadingAnchor), categoryImage.trailingAnchor.constraint(equalTo: self.trailingAnchor), categoryImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
    
    private func configureCategoryLabelConstraints(){
        self.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor), categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    }
    
    private func configureSelectedViewConstraints(){
        self.addSubview(selectedView)
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([selectedView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5), selectedView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5), selectedView.heightAnchor.constraint(equalToConstant: 20), selectedView.widthAnchor.constraint(equalToConstant: 20)])
    }
    
  
    
}

