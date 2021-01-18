//
//  UIView+Separetor.swift
//  IDEA Hospital
//
//  Created by yasser on 12/22/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

 extension UIView {
    convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
    
    func addSeparator() {
        let separatorHeight: CGFloat = 2
        let frame = CGRect(x: 0, y: bounds.height - separatorHeight, width: bounds.width, height: separatorHeight)
        let separator = UIView(frame: frame)
        separator.backgroundColor = .white
        separator.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        
        addSubview(separator)
    }
}
