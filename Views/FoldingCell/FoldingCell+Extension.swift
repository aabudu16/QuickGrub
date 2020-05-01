//
//  FoldingCell+Extension.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 5/1/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit
import MapKit
//MARK:-- extensions
extension FoldingCell: UIScrollViewDelegate{
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(page)
    }
}

extension FoldingCell: MKMapViewDelegate{
    // Do something here with maps
}
