//
//  CustomTextField.swift
//  IDEA Hospital
//
//  Created by yasser on 12/24/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    // MARK:- Properties
    let padding = UIEdgeInsets(top: 0, left: 53, bottom: 0, right: 0)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }
  
    func addLineView(leftImage: UIImage, placeholder: String){
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "PTSans-Bold", size: 15)!])
        let leftIcon = UIImageView(image: leftImage)
        self.leftView = leftIcon
        
        self.textColor = .white
        self.font = UIFont(name: "PTSans-Bold", size: 15)
        self.backgroundColor = .clear
        self.leftViewMode = .always
        self.layoutIfNeeded()
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.height - 2, width: frame.width, height: 2)
        self.borderStyle = .none
        bottomLine.backgroundColor = UIColor.white.cgColor
        self.layer.addSublayer(bottomLine)
        self.layer.masksToBounds = true
    }
}
