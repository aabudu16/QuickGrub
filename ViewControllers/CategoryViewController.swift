//
//  CategoryViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var selectedCategories = [CDYelpCategoryAlias]()
    //MARK: properties
    var layout = UICollectionViewFlowLayout.init()
    var filterParameter:FilterModel?

    var mode: Mode = .view {
        didSet{
            switch mode {
            case .view:
                rightBarButton.title = "Reset"
            case .select:
                rightBarButton.title = "Select All"
            }
        }
    }
    
    lazy var searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        return searchBar
    }()
    
    //MARK: UI Objects
    lazy var categoryCollectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.categoryCell.rawValue)
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = #colorLiteral(red: 0.6938746572, green: 0.6897519231, blue: 0.6970449686, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var containerView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var continueButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icons8-chevron-left-30"), for: .normal)
        button.addTarget(self, action: #selector(handleContinueButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rightBarButton:UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleResetButtonPressed(_:)))
        return button
    }()
    
    lazy var leftBarButton:UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(handleHomeButtomPressed(_:)))
        return button
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureContainerViewConstriant()
        configureSearchBarConstaints()
        configureCollectionViewConstraint()
        configureContinueButton()
    }
    
    //MARK: Objc Selector functions
    @objc func handleHomeButtomPressed(_ sender:UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleResetButtonPressed(_ sender:UIBarButtonItem){
        mode = mode == .view ? .select: .view
    }
    
    @objc func handleContinueButtonPressed(sender:UIButton){
        guard selectedCategories.count > 0 else {
            self.showAlert(alertTitle: nil, alertMessage: "Please select at least one category", actionTitle: "OK")
            return
        }
        guard let filterParameter = filterParameter else {return}
        
        let userFilteredParameter = UserFullFilterModel(filterModel: filterParameter, categories: selectedCategories)
        print(userFilteredParameter)
        let foodVC = FoodImagesViewController()
        foodVC.userFilteredParameter = userFilteredParameter
        navigationController?.pushViewController(foodVC, animated: true)
        print("continue button pressed")
    }
    //MARK: Private Methods
    
    private func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.topItem?.title = "Browse by cuisine"
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    //MARK: Constriaints Function
    
    private func configureContainerViewConstriant(){
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),containerView.heightAnchor.constraint(equalToConstant: 40),containerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    private func configureSearchBarConstaints(){
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor), searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), searchBar.heightAnchor.constraint(equalToConstant: 45)])
    }
    
    private func configureCollectionViewConstraint(){
        view.addSubview(categoryCollectionView)
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([categoryCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor), categoryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), categoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), categoryCollectionView.bottomAnchor.constraint(equalTo: containerView.topAnchor)])
    }
    

    private func configureContinueButton(){
        containerView.addSubview(continueButton)
        
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([continueButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0), continueButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 2), continueButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor), continueButton.widthAnchor.constraint(equalTo: continueButton.heightAnchor)])
    }
    
}

//MARK: Extension
extension CategoryViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {return}

        cell.layer.borderWidth = 2.5
        cell.layer.borderColor = UIColor.darkGray.cgColor
       cell.selectedView.checked = true
        selectedCategories.append(CDYelpCategoryAlias.yelpCategory[indexPath.row])
        print(selectedCategories)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {return}

        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.selectedView.checked = false
        if let index = selectedCategories.firstIndex(of:CDYelpCategoryAlias.yelpCategory[indexPath.row]) {
                   selectedCategories.remove(at: index)
               }
        print(selectedCategories)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
       guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {return}
        cell.categoryLabel.font = UIFont(name: "HoeflerText-Italic", size: 25)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
               guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {return}
         cell.categoryLabel.font = nil

    }
}
extension CategoryViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CDYelpCategoryAlias.yelpCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.categoryCell.rawValue, for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
        
        let category = CDYelpCategoryAlias.yelpCategory[indexPath.row]
        
        cell.categoryLabel.text = category.rawValue.replacingOccurrences(of: "_", with: " ")
        cell.backgroundColor = .white
        cell.layer.setCustomLayer(radius: 0)
        if selectedCategories.contains(category){
            cell.layer.borderWidth = 2.5
          cell.layer.borderColor = UIColor.darkGray.cgColor
          cell.selectedView.checked = true
        }else {
            cell.layer.borderWidth = 1.5
            cell.layer.borderColor = UIColor.gray.cgColor
           cell.selectedView.checked = false
        }
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        let virticalCellCGSize = CGSize(width: (collectionView.frame.size.width - 20) / 2, height: collectionView.frame.size.height / 4)
        return virticalCellCGSize
    }
}

extension CategoryViewController:UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}

