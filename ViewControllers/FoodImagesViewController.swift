//
//  FoodImagesViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/21/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class FoodImagesViewController: UIViewController {
    var layout = UICollectionViewFlowLayout.init()
    enum FoodImageIdentifier:String{
        case foodCell
    }
    //MARK: UI Objects
    lazy var collectionView:UICollectionView = {
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        cv.register(FoodImagesSellectionCollectionViewCell.self, forCellWithReuseIdentifier: FoodImageIdentifier.foodCell.rawValue)
        cv.backgroundColor = .blue
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodImageIdentifier.foodCell.rawValue, for: indexPath) as? FoodImagesSellectionCollectionViewCell else {return UICollectionViewCell()}
        
        cell.foodImage.image = UIImage(systemName: "photo")
        
        return cell
    }
    
}

extension FoodImagesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let virticalCellCGSize = CGSize(width: 200, height: 200)
        return virticalCellCGSize
    }
}

