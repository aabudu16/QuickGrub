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
    var customerReviews = [CDYelpReview](){
        didSet{
            tableView.reloadData()
        }
    }
    
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
        tableview.register(CustomerReviewTableViewCell.self, forCellReuseIdentifier: CustomerReviewsIdentifer.customerReviewsCell.rawValue)
        tableview.estimatedRowHeight = 68
        return tableview
    }()
    
    lazy var dismissButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Reviews", for: .normal)
        button.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: -- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureTableViewConstraints()
        configureDismissButtonConstraints()
    }
    
    //MARK: -- private function
    
    private func setupTableView(){
        view.backgroundColor = .blue
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //MARK: -- @objc function
    
    @objc func dismissButtonPressed(sender:UIButton){
        sender.backgroundColor = .blue
        self.dismiss(animated: true) {
            sender.backgroundColor = .blue
        }
    }
    //MARK: -- Private constraints
    
    private func configureTableViewConstraints(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor), tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor), tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func configureDismissButtonConstraints(){
        view.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([dismissButton.topAnchor.constraint(equalTo: view.topAnchor), dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor), dismissButton.bottomAnchor.constraint(equalTo: tableView.topAnchor)])
    }
}

//MARK: -- Extensions
extension CustomerReviewsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomerReviewsIdentifer.customerReviewsCell.rawValue) as? CustomerReviewTableViewCell else {return UITableViewCell()}
        
        let review = customerReviews[indexPath.row]
        cell.moreYelpReviewsDelegate = self
        cell.profileDelegate = self
        
        cell.customerImage.tag = indexPath.row
        cell.yelpLogo.tag = indexPath.row
        
        cell.customerReviewTableViewCellData(yelpReview: review)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
