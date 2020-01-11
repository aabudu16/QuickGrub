//
//  ForgetPasswordViewController.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 1/11/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit
import TextFieldEffects

class ForgetPasswordViewController: UIViewController {

    //MARK: UI Objects
    lazy var topView:UIView = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleCancelView))
     let view = UIView()
        view.backgroundColor = .blue
        view.addGestureRecognizer(gesture)
        return view
    }()
    

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    //MARK: @objc func
    @objc func handleCancelView(){
       print("view tapped")
    }
}
