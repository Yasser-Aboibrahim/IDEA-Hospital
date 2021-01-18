//
//  UIViewController+Background.swift
//  IDEA Hospital
//
//  Created by yasser on 12/13/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func setupBackground(){
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}
