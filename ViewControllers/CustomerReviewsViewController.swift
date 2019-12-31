//
//  CustomerReviewsViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/30/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class CustomerReviewsViewController: UIViewController {
    
    //MARK: -- Objects
    var customerReviews = [CDYelpReview]()
    var businessID:String!{
        didSet{
            CDYelpFusionKitManager.shared.apiClient.fetchReviews(forBusinessId: businessID, locale: nil) { (response) in
                DispatchQueue.main.async {
                    if let reviews = response?.reviews{
                        self.customerReviews = reviews
                    }
                }
            }
        }
    }
    
    
    lazy var tableView:UITableView = {
        let tableview = UITableView()
        tableview.register(FoldingCell.self, forCellReuseIdentifier: CustomerReviewsIdentifer.customerReviewsCell.rawValue)
        return tableview
    }()
    
    //MARK: -- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureTableViewConstraints()
    }
    
    //MARK: -- private function
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: -- Private constraints
    
    private func configureTableViewConstraints(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor),tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor), tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor), tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}

//MARK: -- Extensions
extension CustomerReviewsViewController: UITableViewDelegate{}
extension CustomerReviewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
