//
//  CustomTextField.swift
//  IDEA Hospital
//
//  Created by yasser on 12/24/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override func awakeFromNib() {
        setupCustomTextField()
    }
    
    func setupCustomTextField(){
        let padding = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0);
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.white.cgColor
        // border.borderColor = borderColor
        border.frame = CGRect(x: 0, y: self.frame.height + 7 - width , width:  self.frame.size.width + 15, height: 1)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
        
    }
    
}
