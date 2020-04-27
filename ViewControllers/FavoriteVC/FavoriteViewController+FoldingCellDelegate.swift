//
//  FavoriteViewController+FoldingCellDelegate.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit
import MapKit

//MARK: -- folding cell Delegate
extension FavoriteViewController: FoldingCellDelegate{
    func navigateToDestination(tag: Int) {
        let businessInfo = businessFullDetail[tag]
            guard let lat = businessInfo.coordinates?.latitude, let long =  businessInfo.coordinates?.longitude else {return}
            
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
                    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
            mapItem.name = businessInfo.name
                    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
    
    func navigateToDetailedViewController(tag: Int) {
        let businessInfo = businessFullDetail[tag]
        
        let restaurantDetailVC = RestaurantDetailViewController()
        restaurantDetailVC.business = businessInfo
        self.navigationController?.pushViewController(restaurantDetailVC, animated: true)

    }
    
    
}




