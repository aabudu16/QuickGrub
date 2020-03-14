//
//  FoodImagesViewController+UICollectionViewDelegate.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

//MARK: Extensions
extension FoodImagesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? FoodImagesSellectionCollectionViewCell else {return}
        let info = userCategorySelectedResults[indexPath.row]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FoodImagesSellectionCollectionViewCell else {return}
        let info = userCategorySelectedResults[indexPath.row]
    
    }
}
