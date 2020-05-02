//
//  FavoriteViewController+UITableViewDataSource.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension FavoriteViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessFullDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResturantCellIdentifier.resturantCell.rawValue) as? FoldingCell else {return UITableViewCell()}
        
        cell.delegate = self
        cell.navigateButtom.tag = indexPath.row
        cell.moreDetailButton.tag = indexPath.row
        cell.heartImage.tag = indexPath.row
        cell.heartImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        let businessInfo = businessFullDetail[indexPath.row]
        let distance = businessFullDetail[indexPath.row]
        cell.configureBusinessData(business: businessInfo, distance: distance)
        cell.distanceLabel.isHidden = true
        return cell
    }
}

