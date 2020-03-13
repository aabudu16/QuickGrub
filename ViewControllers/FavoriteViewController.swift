//
//  FavoriteViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 1/14/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit
import MapKit

class FavoriteViewController: UIViewController {
    var cellHeights: [CGFloat] = []
    var businessFullDetail = [CDYelpBusiness](){
        didSet {
            tableView.reloadData()
        }
    }
 
    var userFavorites = [ UserFavorite](){
        didSet{
            for individualBusiness in userFavorites{
                CDYelpFusionKitManager.shared.apiClient.fetchBusiness(forId: individualBusiness.venueID, locale: nil) { [weak self] (business) in
                    DispatchQueue.main.async {
                        if let eachBusiness = business {
                            self?.businessFullDetail.append(eachBusiness)
                            print(eachBusiness.location)
                        }
                    }
                }
            }
        }
    }
    
    private func getFavorites(){
        guard let userID = FirebaseAuthService.manager.currentUser?.uid else{
            return
        }
        FirestoreService.manager.getFavorites(forUserID: userID) { (result) in
            switch result{
            case .failure(let error):
                self.showAlert(alertTitle: "Error", alertMessage: "Seems to be a problem loading your favorites \(error)", actionTitle: "OK")
            case .success(let favorites):
                DispatchQueue.main.async {
                    self.userFavorites = favorites
                }
            }
        }
    }
    
    enum Const {
        static let closeCellHeight: CGFloat = 179
        static let openCellHeight: CGFloat = 488
        static let rowsCount = 50
    }
    
    lazy var tableView:UITableView = {
        let tableview = UITableView()
        tableview.register(FoldingCell.self, forCellReuseIdentifier: ResturantCellIdentifier.resturantCell.rawValue)
        return tableview
    }()
    
    //MARK:-- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setDelegation()
        configureTableViewConstraints()
        setup()
        getFavorites()
        let attributes = [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPS-ItalicMT", size: 25)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        self.title = "Favorite"
    }
    
    private func setDelegation(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    // MARK: Helpers
    private func setup() {
        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
        tableView.estimatedRowHeight = Const.closeCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        if #available(iOS 10.0, *) {
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        }
    }
    
    // MARK: Actions
    @objc func refreshHandler() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tableView.refreshControl?.endRefreshing()
            }
            self?.tableView.reloadData()
        })
    }
 
    func configureTableViewConstraints(){
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor), tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        
    }
}

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
        let businessInfo = businessFullDetail[indexPath.row]
        let distance = businessFullDetail[indexPath.row]
        cell.configureBusinessData(business: businessInfo, distance: distance)
        cell.distanceLabel.isHidden = true
        return cell
    }
}

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
