//
//  RestaurantDetailViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/28/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    //MARK: - UIObjects
    
    lazy var imageScrollView:UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.isPagingEnabled = true
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.hidesForSinglePage = true
        pc.pageIndicatorTintColor = .blue
        pc.currentPageIndicatorTintColor = .red
        pc.numberOfPages = 3
        return pc
    }()
    
    lazy var logoView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 60))
        view.backgroundColor = .white
        view.layer.borderWidth = 0.5
        view.layer.shadowOpacity = 0.1
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    lazy var logoLabel:UILabel = {
        let label = UILabel()
        label.text = "The Best Resturant Ever"
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir Next Medium 18.0", size: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    lazy var resturantName:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Heavy", size: 23)
        label.text = "Pasteles Del Caribe"
        return label
    }()
    
    lazy var addressTextView:UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.textAlignment = .left
        tv.adjustsFontForContentSizeCategory = false
        tv.isUserInteractionEnabled = false
        tv.text = "218-28 Merrick Blvd, Springfield Gardens, NY 11413"
        tv.font = UIFont(name: "Avenir-Light", size: 19)
        return tv
    }()
    
    lazy var hoursOfOperationTextView:UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.textAlignment = .center
        tv.textAlignment = .left
        tv.adjustsFontForContentSizeCategory = false
        tv.isUserInteractionEnabled = false
        tv.text = "218-28 Merrick Blvd, Springfield Gardens, NY 11413"
        tv.font = UIFont(name: "Avenir-Light", size: 19)
        return tv
    }()
    
    lazy var openOrCloseLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 18)
        label.textAlignment = .center
        return label
    }()
    
    lazy var resturantPhoneNumber:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Light", size: 20)
        return label
    }()
    
    lazy var restaurantMenuButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        // button.addTarget(self, action: #selector(handleRestaurantMenuButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var navigateButtom:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = .black
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        button.layer.shadowRadius = 20.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        // button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        return button
    }()
    
    lazy  var distanceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Medium 18.0", size: 18)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureImageScrollViewConstraints()
        configurePageControlConstraints()
        configureLogoViewConstraints()
        configureLogoLabelConstraints()
    }
    
    //MARK: - Private constraints functions
    private func configureImageScrollViewConstraints(){
        view.addSubview(imageScrollView)
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageScrollView.topAnchor.constraint(equalTo: view.topAnchor),imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),imageScrollView.heightAnchor.constraint(equalToConstant: 350)])
    }
    
    private func configurePageControlConstraints(){
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([pageControl.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: -5), pageControl.centerXAnchor.constraint(equalTo: imageScrollView.centerXAnchor), pageControl.heightAnchor.constraint(equalToConstant: 10), pageControl.widthAnchor.constraint(equalToConstant: 30)])
    }
    
    private func configureLogoViewConstraints(){
        view.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([logoView.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: (logoView.layer.frame.height / 2)), logoView.trailingAnchor.constraint(equalTo: imageScrollView.trailingAnchor, constant: -10), logoView.heightAnchor.constraint(equalToConstant: 60), logoView.widthAnchor.constraint(equalToConstant: 110)])
    }
    
    private func configureLogoLabelConstraints(){
        logoView.addSubview(logoLabel)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([logoLabel.topAnchor.constraint(equalTo: logoView.topAnchor),logoLabel.leadingAnchor.constraint(equalTo: logoView.leadingAnchor),logoLabel.trailingAnchor.constraint(equalTo: logoView.trailingAnchor),logoLabel.bottomAnchor.constraint(equalTo: logoView.bottomAnchor)])
    }
}
