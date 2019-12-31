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
                if let reviews = response?.reviews{
                   self.customerReviews = reviews
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
    }
    
    //MARK: -- private function
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: -- Private constraints
}

extension CustomerReviewsViewController: UITableViewDelegate{}
extension CustomerReviewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
