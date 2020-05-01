//
//  FoodImagesViewController+UICollectionViewDataSource.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension FoodImagesViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCategorySelectedResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodImageIdentifier.foodCell.rawValue, for: indexPath) as? FoodImagesSelectionCollectionViewCell else {return UICollectionViewCell()}
        
        cell.delegate = self
        cell.addItemButton.tag = indexPath.item
        cell.FoodTitleLabel.tag = indexPath.item
        cell.createPulse()
        let info = userCategorySelectedResults[indexPath.row]
        cell.configurefoodImagesCellData(yelpImages: info)
        activityIndicator.stopAnimating()
        cell.itemIsSelected = userFoodImageSelection.contains(info) ? true : false
        return cell
    }
}
