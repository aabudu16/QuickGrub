//
//  CategoryViewController+Delegate.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 5/1/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

//MARK: Delegate
extension CategoryViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {return}
        
        cell.layer.borderWidth = 2.5
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.selectedView.checked = true
        selectedCategories.append(searchCategoryResult[indexPath.row])
        print(selectedCategories)
        countLabel.text = "\(selectedCategories.count)"
        print(selectedCategories.count)
        presentContainerView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {return}
        
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.selectedView.checked = false
        if let index = selectedCategories.firstIndex(of:yelpCategories[indexPath.row]) {
            selectedCategories.remove(at: index)
        }
        countLabel.text = "\(selectedCategories.count)"
        print(selectedCategories.count)
        presentContainerView()
    }
}
