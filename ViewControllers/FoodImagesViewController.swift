//
//  FoodImagesViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/21/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class FoodImagesViewController: UIViewController {
    enum FoodImageIdentifier:String{
        case foodCell
    }
    //MARK: UI Objects
    lazy var collectionView:UICollectionView = {
        var layout = UICollectionViewFlowLayout.init()
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.register(FoodImagesSellectionCollectionViewCell.self, forCellWithReuseIdentifier: FoodImageIdentifier.foodCell.rawValue)
        cv.backgroundColor = .white
        return cv
    }()
    
    lazy var transparentView:UIView = {
        let tv = UIView(frame: UIScreen.main.bounds)
        tv.layer.cornerRadius = 10
        tv.layer.masksToBounds = true
        tv.clipsToBounds = true
        tv.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        tv.isUserInteractionEnabled = false
        return tv
    }()
    
    lazy var scrollDownIndicator:UIImageView = {
        let gifImage = UIImageView()
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = transparentView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(name: "scrollDownGif")
        return gifImage
    }()
    
    lazy var scrollLabel:UILabel = {
        let label = UILabel()
        label.text = "Scoll image into the pot"
        label.textColor = .white
        label.font = label.font.withSize(15)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureCollectionviewConstraints()
        configureTransparentViewConstraints()
        configureScrollDownIndicatorConstraints()
        configureScrollLabelConstraints()
    }
    
     // MARK: objc function
    @objc func handleFoodColorBadge(){
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
          showAlert(with: "vegertarian", and: """
    Vegetarian lifestyles are associated with a reduced
    risk of many chronic illnesses, including heart disease,
    many types of cancer, diabetes, high blood pressure,
    and obesity.
    """)
       }
    
    // MARK: Private function
    private func showAlert(with title: String, and message: String) {
          let alertVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
          alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
          present(alertVC, animated: true, completion: nil)
      }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: Private constraints func
    private func configureCollectionviewConstraints(){
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: self.view.topAnchor), collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
    
    private func configureTransparentViewConstraints(){
        self.view.addSubview(transparentView)
        transparentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([transparentView.heightAnchor.constraint(equalToConstant: 200), transparentView.widthAnchor.constraint(equalToConstant: 180), transparentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor), transparentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])
    }
    
    private func configureScrollDownIndicatorConstraints(){
        self.transparentView.addSubview(scrollDownIndicator)
        scrollDownIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([scrollDownIndicator.topAnchor.constraint(equalTo: transparentView.topAnchor, constant: 30), scrollDownIndicator.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor), scrollDownIndicator.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor) ,scrollDownIndicator.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor)])
    }
    
    private func configureScrollLabelConstraints(){
        self.transparentView.addSubview(scrollLabel)
        scrollLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([scrollLabel.topAnchor.constraint(equalTo: transparentView.topAnchor), scrollLabel.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor), scrollLabel.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor) , scrollLabel.heightAnchor.constraint(equalToConstant: 50)])
    }
    
}

 //MARK: Extensions
extension FoodImagesViewController: UICollectionViewDelegate{}

extension FoodImagesViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodImageIdentifier.foodCell.rawValue, for: indexPath) as? FoodImagesSellectionCollectionViewCell else {return UICollectionViewCell()}
        
        cell.foodImage.image = UIImage(systemName: "photo")
        cell.starRatings.image = UIImage(named: "fourStars")
        cell.categoryNameLabel.text = "Catergory name"
        cell.FoodTitleLabel.text = "Food title"
       // cell.foodColorBadge.backgroundColor = .red
        cell.foodColorBadge.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFoodColorBadge)))
//        cell.foodColorBadge.addTarget(self, action: #selector(handleFoodColorBadge(sender:)), for: .touchUpInside)
        
        CustomLayer.shared.createCustomlayer(layer: cell.layer, cornerRadius: 2)
        cell.layer.cornerRadius = 25
        return cell
    }
    
}

extension FoodImagesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let virticalCellCGSize = CGSize(width: 280, height: 400)
        return virticalCellCGSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets.init(top: -90, left: 60, bottom: 100, right: 100)
    }
    // spacing between cells in the VC
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }
    
}

