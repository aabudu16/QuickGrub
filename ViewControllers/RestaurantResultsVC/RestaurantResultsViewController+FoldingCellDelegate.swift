//
//  RestaurantResultsViewController+FoldingCellDelegate.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseAuth

//MARK:-- Folding cell delegate
extension RestaurantResultsViewController: FoldingCellDelegate{
    
    func navigateToDetailedViewController(tag: Int) {
        let businessInfo = businessFullDetail[tag]
        let restaurantDetailVC = RestaurantDetailViewController()
        restaurantDetailVC.SetFavoriteButton = false
        restaurantDetailVC.business = businessInfo
        self.navigationController?.pushViewController(restaurantDetailVC, animated: true)
    }
    
    func handleFavorite(tag: Int) {
        let businessInfo = businessFullDetail[tag]
        guard let cell = tableView.cellForRow(at: IndexPath(row: tag, section: 0)) as? FoldingCell else {return}
        guard let currentUser = FirebaseAuthService.manager.currentUser else {return}
        if currentCount < 5{
        if userCurrentFavorites.contains(where: {$0.venueID == businessInfo.id}) {
            
            print("Already added")
            
            
//            
//            FirestoreService.manager.deleteFavorite(businessID: businessInfo.id!) { (result) in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                case .success(()):
//                    print("deleted")
//                }
//            }
//            
//            getFavorites()
            
        }else {
            createFavorites(currentUser: currentUser, businessInfo: businessInfo, cell: cell)
        }
        }else {
            print("5 is the max")
        }
        getFavorites()
    }
    
    private func createFavorites(currentUser:User, businessInfo: CDYelpBusiness, cell:FoldingCell){
        let myFavorite = UserFavorite(creatorID:  currentUser.uid, venueID: businessInfo.id!, name: businessInfo.name!)
        FirestoreService.manager.createFavorite(favorite: myFavorite) { (result) in
            switch result{
            case .failure(let error):
                self.showAlert(alertTitle: "Error", alertMessage: "Seems to have a problem adding this item to your favorites. please try again \(error)", actionTitle: "OK")
            case .success(()):
                self.showAlert(alertTitle: "Success", alertMessage: "Added to your favorites", actionTitle: "OK")
                cell.heartImage.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.white), for: .normal)
            }
        }
    }
    
    func navigateToDestination(tag: Int) {
        let businessInfo = businessFullDetail[tag]
        guard let lat = businessInfo.coordinates?.latitude, let long =  businessInfo.coordinates?.longitude else {return}
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = businessInfo.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
}


