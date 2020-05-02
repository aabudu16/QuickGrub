//
//  ResturantResultsViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class RestaurantResultsViewController: UIViewController {
    var userCurrentFavorites = [UserFavorite]()
    var businessFullDetail = [CDYelpBusiness](){
        didSet {
            tableView.reloadData()
        }
    }
    
    var userFoodImageSelection = [ CDYelpBusiness](){
        didSet{
            for individualBusiness in userFoodImageSelection{
                CDYelpFusionKitManager.shared.apiClient.fetchBusiness(forId: individualBusiness.id, locale: .english_unitedStates) { [weak self] (result) in
                    DispatchQueue.global(qos: .default).async {
                        switch result {
                        case .success(let business):
                            self?.businessFullDetail.append(business)
                        case .failure(let error):
                            self?.showAlert(alertTitle: "Ohh oh", alertMessage: "Seem you caught an error \(error)", actionTitle: "OK")
                        }
                    }
                }
            }
        }
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
        getFavorites()
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
        //    if #available(iOS 10.0, *) {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        //  }
    }
    
    func getFavorites(){
        guard let userID = FirebaseAuthService.manager.currentUser?.uid else{
            return
        }
        FirestoreService.manager.getFavorites(forUserID: userID) {[weak self] (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let favorites):
                DispatchQueue.main.async {
                    self?.userCurrentFavorites = favorites
                    self!.currentCount = favorites.count
                }
            }
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
