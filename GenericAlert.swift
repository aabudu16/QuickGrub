//
//  GenericAlert.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/14/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

struct GenericAlert{
    static  func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    }
}
