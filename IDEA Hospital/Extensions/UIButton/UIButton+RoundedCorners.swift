//
//  UIButton+RoundedCorners.swift
//  IDEA Hospital
//
//  Created by yasser on 1/1/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import UIKit

extension UIButton {
    
    func roundCorners(with CACornerMask: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [CACornerMask]
    }
    
//    Top right
//
//    roundCorners(with: [.layerMinXMinYCorner], radius: 20)
//    Top left
//
//    roundCorners(with: [.layerMaxXMinYCorner], radius: 20)
//    Bottom right
//
//    roundCorners(with: [.layerMinXMaxYCorner], radius: 20)
//    Bottom left
//
//    roundCorners(with: [.layerMaxXMaxYCorner], radius: 20)
}
