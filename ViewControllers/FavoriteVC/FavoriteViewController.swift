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
    //MARK:-- Properties
    var cellHeights: [CGFloat] = []
    let deadlineTime = DispatchTime.now() + .seconds(1)
    let group = DispatchGroup()
    let information = "You have nothing saved"
    
    //MARK:-- Computed Properties
    var businessFullDetail = [CDYelpBusiness](){
        didSet {
            DispatchQueue.main.async {
                self.hideInformationLabel()
                self.tableView.reloadData()
            }
        }
    }
    
    var userFavorites = [ UserFavorite](){
        didSet{
            for individualBusiness in userFavorites{
                group.enter()
                CDYelpFusionKitManager.shared.apiClient.fetchBusiness(forId: individualBusiness.venueID, locale: .english_unitedKingdom) { [weak self] (result) in
                    DispatchQueue.global(qos: .default).async {
                        switch result {
                        case .success(let business):
                            self?.businessFullDetail.append(business)
                            self?.group.leave()
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
    
       lazy var informationLabel:UILabel = {
        let label = UILabel(textAlignment: .center, text: information, fontName: "Avenir-Heavy", fontSize: 25, color: .lightGray)
        label.numberOfLines = 0
        return label
    }()
    
    //MARK:-- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setDelegation()
        configureTableViewConstraints()
        configureInformationLabelConstraints()
        setup()
        getFavorites()
        navigationFont()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        self.title = "Favorite"
    }
    
    //MARK:-- Private func
    private func setDelegation(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func navigationFont(){
       let attributes = [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPS-ItalicMT", size: 25)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
    
    private func hideInformationLabel() {
         informationLabel.isHidden = userFavorites.count > 0 ? true : false
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
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tableView.refreshControl?.endRefreshing()
            }
            self?.tableView.reloadData()
        })
    }
    
   private func configureTableViewConstraints(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor), tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        
    }
    
    private func configureInformationLabelConstraints(){
        view.addSubview(informationLabel)
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([informationLabel.topAnchor.constraint(equalTo: view.topAnchor), informationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor), informationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor), informationLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}
