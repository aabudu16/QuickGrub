//
//  ResturantResultsViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RestaurantResultsViewController: UIViewController {
    
    var businessFullDetail = [CDYelpBusiness](){
        didSet {
           print(businessFullDetail.count)
           tableView.reloadData()
        }
    }
    
    var userFoodImageSelection = [ CDYelpBusiness](){
        didSet{
            for individualBusiness in userFoodImageSelection{
                CDYelpFusionKitManager.shared.apiClient.fetchBusiness(forId: individualBusiness.id, locale: nil) { [weak self] (business) in
                    DispatchQueue.main.async {
                       if let business = business {
                        self?.businessFullDetail.append(business)
                        }
                    }
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
    
    var cellHeights: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
        configureTableViewConstraints()
        setup()
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
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: self.view.topAnchor), tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        
    }
}

extension RestaurantResultsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FoldingCell else {return}
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        
            if cell.frame.maxY > tableView.frame.maxY {
                tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          guard case let cell as FoldingCell = cell else {
                  return
              }
         cell.backgroundColor = .clear
        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }
}

extension RestaurantResultsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  businessFullDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResturantCellIdentifier.resturantCell.rawValue, for: indexPath) as? FoldingCell else {return UITableViewCell()}
        cell.delegate = self
        cell.navigateButtom.tag = indexPath.row
        cell.detailVCDelegate = self
        cell.moreDetailButton.tag = indexPath.row
        let businessInfo = businessFullDetail[indexPath.row]
        let distance = userFoodImageSelection[indexPath.row]
        cell.configureBusinessData(business: businessInfo, distance: distance)

        return cell
    }
    
    
}

extension RestaurantResultsViewController: FoldingCellDelegate{
    func navigateToDestination(tag: Int) {
       let businessInfo = businessFullDetail[tag]
        guard let lat = businessInfo.coordinates?.latitude, let long =  businessInfo.coordinates?.longitude else {return}
        
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = businessInfo.name
                mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
}

extension RestaurantResultsViewController: NavigateToRestaurantDetailVCDelegate{
    func navigateToDetailedViewController(tag: Int) {
        let businessInfo = businessFullDetail[tag]
        
        let restaurantDetailVC = RestaurantDetailViewController()
        restaurantDetailVC.business = businessInfo
        self.navigationController?.pushViewController(restaurantDetailVC, animated: true)
    }
    
}

