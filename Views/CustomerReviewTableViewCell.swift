//
//  CustomerReviewTableViewCell.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/31/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class CustomerReviewTableViewCell: UITableViewCell {

  //MARK: -- Objects
    lazy var customerImage:UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        iv.layer.cornerRadius = 40
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "profileImage")
        return iv
    }()
    
    lazy var yelpLogo:UIImageView = {
          let iv = UIImageView()
          return iv
      }()
    
    lazy var ratingsLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "4.5 / 5.0"
        return label
    }()
    
    lazy var timeCreatingLabel:UILabel = {
           let label = UILabel()
           label.textAlignment = .left
           label.text = "3.34pm 3/3/2019"
           return label
       }()
    
    lazy var nameLabel:UILabel = {
           let label = UILabel()
           label.textAlignment = .left
           label.text = "Mike A"
           return label
       }()
    
    lazy var reviewTextLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "One of the best Thai places in Long Island Pros:  + Simply quaint - it's such a great spot to grab a nice meal on your way home+ Free delivery - minimum..."
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style:style, reuseIdentifier: reuseIdentifier)
        configureCustomerImageConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCustomerImageConstraints(){
        self.addSubview(customerImage)
        customerImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([customerImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5), customerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5), customerImage.heightAnchor.constraint(equalToConstant: 80), customerImage.widthAnchor.constraint(equalToConstant: 80)])
    }
}
