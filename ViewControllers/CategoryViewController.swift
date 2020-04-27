//
//  CategoryViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var containerViewTopConstraints:NSLayoutConstraint?
    var newContainerViewTopConstraints:NSLayoutConstraint?
    var searchBarTopConstraints:NSLayoutConstraint?
    var newSearchBarTopConstraints:NSLayoutConstraint?
    var searchIconBottomConstraints:NSLayoutConstraint?
    var yelpCategories = CDYelpCategoryAlias.yelpCategory
    var currentState:CurrentState = .deselected
    var selectedCategories = [CDYelpCategoryAlias]()
    //MARK: properties
    var layout = UICollectionViewFlowLayout.init()
    
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
    let containerHeight:CGFloat = 80
    let searchImage = UIImage(systemName: "magnifyingglass.circle.fill")!
    let cancelImage = UIImage(systemName: "xmark.circle.fill")!
    
    var searchCategoryResult:[CDYelpCategoryAlias]{
        get{
            guard let searchCategoryString = searchCategoryString else {
                return yelpCategories
            }
            guard searchCategoryString != "" else {
                return yelpCategories
            }
            
            return yelpCategories.filter({$0.rawValue.lowercased() == searchCategoryString.lowercased()})
        }
        
    }
    
    var searchCategoryString:String? = nil {
        didSet {
            self.categoryCollectionView.reloadData()
        }
    }
    
    
    lazy var searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.alpha = 0
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
        view.backgroundColor = .blue
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
        button.tintColor = .black
        return button
    }()
    
    lazy var leftBarButton:UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "house"), style: .plain, target: self, action: #selector(handleHomeButtomPressed(_:)))
        button.tintColor = .black
        return button
    }()
    
    lazy var searchIcon:UIImageView = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentSearchBar(sender:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        image.image = self.searchImage
        image.layer.cornerRadius = image.frame.height / 2
        image.tintColor = .systemOrange
        image.backgroundColor = .white
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
        return image
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSearchBarConstaints()
        configureCollectionViewConstraint()
        configureContainerViewConstriant()
        configureContinueButton()
        configureSearchIconConstraints()
        addKeyBoardHandlingObservers()
    }
    
    //MARK: Objc Selector functions
    @objc func handleHomeButtomPressed(_ sender:UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleResetButtonPressed(_ sender:UIBarButtonItem){
        mode = mode == .view ? .select: .view
    }
    
    @objc func presentSearchBar(sender:UITapGestureRecognizer) {
        switch currentState{
        case .deselected:
            presentSearchBar()
        case .selected:
            hideSearchBar()
        }
    }
    
    @objc func handleContinueButtonPressed(sender:UIButton){
        guard selectedCategories.count > 0 else {
            self.showAlert(alertTitle: nil, alertMessage: "Please select at least one category", actionTitle: "OK")
            return
        }
        
        let userFilteredParameter = SelectedCategoriesModel(categories: selectedCategories)
        print(userFilteredParameter)
        let foodVC = FoodImagesViewController()
        foodVC.userFilteredParameter = userFilteredParameter
        navigationController?.pushViewController(foodVC, animated: true)
        print("continue button pressed")
    }
    
    @objc func handleKeyBoardShowing(sender notification:Notification){
        guard let infoDict = notification.userInfo else {return}
        guard let keyboardFreme = infoDict[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        guard let duration = infoDict[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        self.searchIconBottomConstraints?.constant = -(keyboardFreme.height + 20)
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleKeyBoardHiding(sender notification:Notification){
        guard let infoDict = notification.userInfo else {return}
        guard let duration = infoDict[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        self.searchIconBottomConstraints?.constant = -80
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: Private Methods
    private func presentSearchBar(){
        NSLayoutConstraint.deactivate([searchBarTopConstraints!])
        NSLayoutConstraint.activate([newSearchBarTopConstraints!])
        UIView.animate(withDuration: 0.3) {[weak self] in
            self?.searchBar.alpha = 1
            self?.searchIcon.image = self?.cancelImage
            self?.currentState = .selected
            self?.view.layoutIfNeeded()
        }
    }
    
    private func hideSearchBar(){
        NSLayoutConstraint.deactivate([newSearchBarTopConstraints!])
        NSLayoutConstraint.activate([searchBarTopConstraints!])
        searchBar.resignFirstResponder()
        UIView.animate(withDuration: 0.3) {[weak self] in
            self?.searchBar.alpha = 0
            self?.searchIcon.image = self?.searchImage
            self?.currentState = .deselected
            self?.view.layoutIfNeeded()
        }
    }
    
    private func presentContainerView(){
        if selectedCategories.count > 0{
            NSLayoutConstraint.deactivate([containerViewTopConstraints!])
            NSLayoutConstraint.activate([newContainerViewTopConstraints!])
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.80, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else{
            NSLayoutConstraint.activate([containerViewTopConstraints!])
            NSLayoutConstraint.deactivate([newContainerViewTopConstraints!])
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (_) in
                print("nothing")
            })
        }
    }
    
    private func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.topItem?.title = "Browse by cuisine"
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func addKeyBoardHandlingObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardShowing(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardHiding(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: Constriaints Function
    
    private func configureContainerViewConstriant(){
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),containerView.heightAnchor.constraint(equalToConstant: containerHeight)])
        
        containerViewTopConstraints = containerView.topAnchor.constraint(equalTo: self.view.bottomAnchor)
        newContainerViewTopConstraints = containerView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(containerHeight) + 20)
        NSLayoutConstraint.activate([containerViewTopConstraints!])
        NSLayoutConstraint.deactivate([newContainerViewTopConstraints!])
        
    }
    
    private func configureSearchBarConstaints(){
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), searchBar.heightAnchor.constraint(equalToConstant: 45)])
        
        searchBarTopConstraints = searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -(searchBar.frame.height))
        newSearchBarTopConstraints = searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0)
        NSLayoutConstraint.activate([searchBarTopConstraints!])
        NSLayoutConstraint.deactivate([newSearchBarTopConstraints!])
    }
    
    private func configureCollectionViewConstraint(){
        view.addSubview(categoryCollectionView)
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([categoryCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor), categoryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor), categoryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor), categoryCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    
    private func configureContinueButton(){
        containerView.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([continueButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0), continueButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 2), continueButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor), continueButton.widthAnchor.constraint(equalTo: continueButton.heightAnchor)])
    }
    
    private func configureSearchIconConstraints(){
        view.addSubview(searchIcon)
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([searchIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10), searchIcon.heightAnchor.constraint(equalToConstant: 45), searchIcon.widthAnchor.constraint(equalToConstant: 45)])
        searchIconBottomConstraints = searchIcon.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -80)
        NSLayoutConstraint.activate([searchIconBottomConstraints!])
    }
}

//MARK: Extension
extension CategoryViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {return}
        
        cell.layer.borderWidth = 2.5
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.selectedView.checked = true
        selectedCategories.append(searchCategoryResult[indexPath.row])
        print(selectedCategories)
        presentContainerView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else {return}
        
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.selectedView.checked = false
        if let index = selectedCategories.firstIndex(of:yelpCategories[indexPath.row]) {
            selectedCategories.remove(at: index)
        }
        print(selectedCategories)
        presentContainerView()
    }
}

extension CategoryViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchCategoryResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.categoryCell.rawValue, for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
        
        let category = searchCategoryResult[indexPath.row]
        cell.configureCategoryCollectionViewCell(with: category)
        
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCategoryString = searchBar.text
    }
}
