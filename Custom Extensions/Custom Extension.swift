//
//  UILabel-Extension.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 11/19/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects

//MARK: UILabel extension
extension UILabel{
    public convenience init(textAlignment:NSTextAlignment, text:String){
        self.init()
        self.numberOfLines = 0
        self.textColor = .black
        self.text = text
        self.textAlignment = textAlignment
    }
}

//MARK: UIButton extension
extension UIButton{
    convenience init(alpha:CGFloat, contentMode: UIView.ContentMode){
        self.init()
        self.alpha = alpha
        self.contentMode = contentMode
    }
    convenience init(image:UIImage, color: CGColor){
        self.init()
        self.contentMode = .scaleAspectFit
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 25
        self.backgroundColor = .white
        self.setBackgroundImage(image, for: .normal)
        self.layer.borderColor = color
        
    }
}

//MARK: -- UILayer Extension

extension CALayer{
  func setCustomLayer(radius:CGFloat){
                 cornerRadius = radius
                  borderWidth = 2
                  borderColor = UIColor.black.cgColor
                  masksToBounds = true
                  shadowColor = UIColor.black.cgColor
                  shadowOffset = CGSize(width: 0, height: 5.0)
                  shadowRadius = 20.0
                  shadowOpacity = 0.5
                  masksToBounds = false
        }
}

//MARK: UITextField extension
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

//MARK: HoshiTextField extension
extension HoshiTextField {
    public convenience init(keyboardType:  UIKeyboardType , placeholder: String, borderActiveColor: UIColor){
        self.init()
        self.keyboardType = keyboardType
        self.placeholder = text
        self.borderInactiveColor = .gray
        self.borderActiveColor = borderActiveColor
    }
}
//MARK: UIColor extension
extension UIColor {
    static func generateColorValue(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}
//MARK: layer extension
struct CustomLayer{
    static let shared = CustomLayer()
    func createCustomlayer(layer:CALayer, cornerRadius:CGFloat){
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5.0)
        layer.shadowRadius = 20.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    func createCustomlayers(layer:CALayer, cornerRadius:CGFloat, backgroundColor:CGColor){
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5.0)
        layer.shadowRadius = 20.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.backgroundColor = backgroundColor
    }
}



