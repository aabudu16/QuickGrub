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
    
    func handleFavorite(tag: Int) {
                let businessInfo = businessFullDetail[tag]
        guard let currentUser = FirebaseAuthService.manager.currentUser else {return}
        
        let myFavorite = UserFavorite(creatorID:  currentUser.uid, venueID: businessInfo.id!, name: businessInfo.name!)
        
        FirestoreService.manager.createFavorite(favorite: myFavorite) { (result) in
            switch result{
            case .failure(let error):
                self.showAlert(alertTitle: "Error", alertMessage: "Seems to have a problem adding this item to your favorites. please try again \(error)", actionTitle: "OK")
            case .success(()):
                self.showAlert(alertTitle: "Success", alertMessage: "Added to your favorites", actionTitle: "OK")
            }
        }
    }
    
    func navigateToDetailedViewController(tag: Int) {
        let businessInfo = businessFullDetail[tag]
        
        let restaurantDetailVC = RestaurantDetailViewController()
        restaurantDetailVC.business = businessInfo
        self.navigationController?.pushViewController(restaurantDetailVC, animated: true)

    }
    
    
}




