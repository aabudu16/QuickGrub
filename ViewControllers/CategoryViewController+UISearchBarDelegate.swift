//
//  CategoryViewController+UISearchBarDelegate.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 5/1/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

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
