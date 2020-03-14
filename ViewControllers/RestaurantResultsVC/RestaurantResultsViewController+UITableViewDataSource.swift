//
//  RestaurantResultsViewController+UITableViewDataSource.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension RestaurantResultsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  businessFullDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResturantCellIdentifier.resturantCell.rawValue, for: indexPath) as? FoldingCell else {return UITableViewCell()}
        cell.delegate = self
        cell.navigateButtom.tag = indexPath.row
        cell.moreDetailButton.tag = indexPath.row
        cell.heartImage.tag = indexPath.row
        let businessInfo = businessFullDetail[indexPath.row]
        let distance = userFoodImageSelection[indexPath.row]
        cell.configureBusinessData(business: businessInfo, distance: distance)

        return cell
    }
}

