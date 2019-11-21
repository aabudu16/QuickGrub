//
//  FoodImagesViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/21/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class FoodImagesViewController: UIViewController {
    
    enum FoodImageIdentifier:String{
        case foodCell
    }
    //MARK: UI Objects
    lazy var collectionView:UICollectionView = {
        let cv = UICollectionView()
        cv.register(FoodImagesSellectionCollectionViewCell.self, forCellWithReuseIdentifier: FoodImageIdentifier.foodCell.rawValue)
        return cv
    }()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureCollectionviewConstraints()
        
    }
    
    // MARK: Private function
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: Private constraints func
    private func configureCollectionviewConstraints(){
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: self.view.topAnchor), collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
    
}

extension FoodImagesViewController: UICollectionViewDelegate{}

extension FoodImagesViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
