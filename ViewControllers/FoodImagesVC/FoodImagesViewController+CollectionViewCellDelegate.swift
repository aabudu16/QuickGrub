//
//  FoodImagesViewController+CollectionViewCellDelegate.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension FoodImagesViewController: CollectionViewCellDelegate{
    func handleShortCut(tag: Int) {
        guard let cell = collectionView.cellForItem(at: IndexPath(row: tag, section: 0)) as? FoodImagesSelectionCollectionViewCell else {return}
        
        cell.shortCutViewTopAnchor?.isActive = false
        cell.newShortCutViewTopAnchor?.isActive = true
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cell.shortCutView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            cell.layoutIfNeeded()
        }, completion: nil)
    }
    
    func addSelectedFood(tag: Int) {
        let info = userCategorySelectedResults[tag]
        guard let cell = collectionView.cellForItem(at: IndexPath(row: tag, section: 0)) as? FoodImagesSelectionCollectionViewCell else {return}
        
        if cell.itemIsSelected == false{
            print(tag)
            userFoodImageSelection.append(info)
            print("Amount \(userFoodImageSelection.count)")
            cell.itemIsSelected = true
        }else{
            print("Take care of deleting from array at that index")
            cell.itemIsSelected = false
        }
    }
}

