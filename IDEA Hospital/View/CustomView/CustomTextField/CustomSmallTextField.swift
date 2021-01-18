//
//  CustomSmallTextField.swift
//  IDEA Hospital
//
//  Created by Hossam Yasser on 1/8/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class CustomSmallTextField: UITextField {
    
    // MARK:- Properties
    let padding = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
    
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
    
    func addunderline(placeholder: String) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "PTSans-Bold", size: 12)!])
        self.textColor = .white
        self.font = UIFont(name: "PTSans-Bold", size: 12)
        self.backgroundColor = .clear
        self.leftViewMode = .always
        self.layoutIfNeeded()
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        self.borderStyle = .none
        bottomLine.backgroundColor = UIColor.white.cgColor
        self.layer.addSublayer(bottomLine)
        self.layer.masksToBounds = true
    }
}

