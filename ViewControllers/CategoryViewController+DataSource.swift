//
//  CategoryViewController+DataSource.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 5/1/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension CategoryViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchCategoryResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.categoryCell.rawValue, for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
        
        let category = searchCategoryResult[indexPath.row]
        cell.configureCategoryCollectionViewCell(with: category)
        
        if selectedCategories.contains(category){
            cell.layer.borderWidth = 2.5
            cell.layer.borderColor = UIColor.darkGray.cgColor
            cell.selectedView.checked = true
        }else {
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.selectedView.checked = false
        }
        return cell
    }
}
