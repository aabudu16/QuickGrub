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
        let guesture = UITapGestureRecognizer(target: self, action: #selector(customerImageViewDoubleTapped(sender:)))
        guesture.numberOfTapsRequired = 2
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFill
        image.addGestureRecognizer(guesture)
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 0.2
        return image
    }()
    
    lazy var yelpLogo:UIImageView = {
        let guesture = UITapGestureRecognizer(target: self, action: #selector(yelpImageViewTapped(sender:)))
        guesture.numberOfTapsRequired = 1
        let image = UIImageView()
        image.image = UIImage(named: "yelplogo-1")
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(guesture)
        return image
    }()
    
    lazy var readMoreLabel:UILabel = {
        let label = UILabel()
        label.text = "Read more"
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        label.font = UIFont(name: "Avenir-Light", size: 15)
        return label
    }()
    
    lazy var ratingsLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Light", size: 16)
        return label
    }()
    
    lazy var timeCreatingLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.4234377742, green: 0.4209252, blue: 0.4253720939, alpha: 1)
        label.font = UIFont(name: "Avenir-Light", size: 14)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
         label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var reviewTextLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Light", size: 18)
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
        //configureReadMoreLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -- @objc function
    
    @objc func customerImageViewDoubleTapped(sender:UITapGestureRecognizer){
        print("customer image dobble tapped")
    }
    
    @objc func yelpImageViewTapped(sender:UITapGestureRecognizer){
           print("customer image dobble tapped")
       }
    
    //MARK:-- pubic function
    
     public func customerReviewTableViewCellData(yelpReview:CDYelpReview){
         let image = UIImage(named: "profileImage")
        customerImage.kf.setImage(with: yelpReview.user?.imageUrl, placeholder: image)
        
        if let ratings = yelpReview.rating{
            ratingsLabel.text = "\(ratings) / 5 Stars"
        }
        
        if let timeCreating = yelpReview.timeCreated{
            timeCreatingLabel.text = timeCreating
        }
        
        if let name = yelpReview.user?.name{
            nameLabel.text = name
        }
        
        if let review = yelpReview.text{
            reviewTextLabel.text = review
        }
    }
    //MARK:-- Private constraints
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
        NSLayoutConstraint.activate([ratingsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor), ratingsLabel.leadingAnchor.constraint(equalTo: customerImage.trailingAnchor, constant: 3), ratingsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor), ratingsLabel.bottomAnchor.constraint(equalTo: customerImage.bottomAnchor, constant: -20)])
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
        NSLayoutConstraint.activate([yelpLogo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1), yelpLogo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3), yelpLogo.heightAnchor.constraint(equalToConstant: 40), yelpLogo.widthAnchor.constraint(equalToConstant: 100)])
    }
    
    private func configureReadMoreLabelConstraints(){
        self.addSubview(readMoreLabel)
        readMoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([readMoreLabel.bottomAnchor.constraint(equalTo: yelpLogo.bottomAnchor), readMoreLabel.trailingAnchor.constraint(equalTo: yelpLogo.leadingAnchor), readMoreLabel.heightAnchor.constraint(equalToConstant: 20), readMoreLabel.widthAnchor.constraint(equalToConstant: 90)])
    }
}
