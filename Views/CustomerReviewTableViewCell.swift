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
        iv.image = UIImage(named: "yelpLogo")
        iv.layer.borderColor = UIColor.blue.cgColor
        iv.layer.borderWidth = 2
        return iv
    }()
    
    lazy var ratingsLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Light", size: 19)
        label.text = "4.5 / 5.0 Stars"
        
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.borderWidth = 2
        return label
    }()
    
    lazy var timeCreatingLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.4234377742, green: 0.4209252, blue: 0.4253720939, alpha: 1)
        label.font = UIFont(name: "Avenir-Light", size: 15)
        label.text = "3.34pm 3/3/2019"
        
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.borderWidth = 2
        return label
    }()
    
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 18)
        label.text = "Mike A"
        
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.borderWidth = 2
        return label
    }()
    
    lazy var reviewTextLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Light", size: 19)
        label.text = "One of the best Thai places in Long Island Pros:  + Simply quaint - it's such a great spot to grab a nice meal on your way home+ Free delivery - minimum..."
        
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.borderWidth = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        configureCustomerImageConstraints()
        configureNameLabelConstraints()
        configureRatingsLabelConstraints()
        configureTimeCreatingLabelConstraints()
        configureReviewTextLabelConstraints()
        configureYelpLogoConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCustomerImageConstraints(){
        self.addSubview(customerImage)
        customerImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([customerImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5), customerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5), customerImage.heightAnchor.constraint(equalToConstant: 80), customerImage.widthAnchor.constraint(equalToConstant: 80)])
    }
    
    private func configureNameLabelConstraints(){
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalTo: customerImage.topAnchor), nameLabel.leadingAnchor.constraint(equalTo: customerImage.trailingAnchor, constant: 3), nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor), nameLabel.heightAnchor.constraint(equalToConstant: customerImage.frame.height / 2)])
    }
    
    private func configureRatingsLabelConstraints(){
       self.addSubview(ratingsLabel)
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ratingsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor), ratingsLabel.leadingAnchor.constraint(equalTo: customerImage.trailingAnchor, constant: 3), ratingsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor), ratingsLabel.bottomAnchor.constraint(equalTo: customerImage.bottomAnchor)])
    }
    
    private func configureTimeCreatingLabelConstraints(){
        self.addSubview(timeCreatingLabel)
        timeCreatingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([timeCreatingLabel.topAnchor.constraint(equalTo: customerImage.bottomAnchor,constant: 1), timeCreatingLabel.leadingAnchor.constraint(equalTo: customerImage.leadingAnchor), timeCreatingLabel.heightAnchor.constraint(equalToConstant: 30), timeCreatingLabel.widthAnchor.constraint(equalToConstant: self.frame.width / 2)])
    }
    
    private func configureReviewTextLabelConstraints(){
        self.addSubview(reviewTextLabel)
        reviewTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([reviewTextLabel.topAnchor.constraint(equalTo: timeCreatingLabel.bottomAnchor,constant: 3), reviewTextLabel.leadingAnchor.constraint(equalTo: customerImage.leadingAnchor), reviewTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -45), reviewTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
    
    private func configureYelpLogoConstraints(){
        self.addSubview(yelpLogo)
        yelpLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([yelpLogo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3), yelpLogo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3), yelpLogo.heightAnchor.constraint(equalToConstant: 40), yelpLogo.widthAnchor.constraint(equalToConstant: 40)])
    }
}
