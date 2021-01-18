//
//  UIViewController+SetStatusBar.swift
//  IDEA Hospital
//
//  Created by yasser on 12/28/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

extension UIViewController {
    func setStatusBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.init(white: 204.0/255.0, alpha: 1.0)
        
    }
}
