//
//  GenericAlert.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 12/14/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert (alertTitle: String?, alertMessage: String, actionTitle: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let alertAction1 = UIAlertAction(title: actionTitle, style: .default) { (action) in

        }

        alert.addAction(alertAction1)
        present(alert, animated: true, completion: nil)
    }
}
