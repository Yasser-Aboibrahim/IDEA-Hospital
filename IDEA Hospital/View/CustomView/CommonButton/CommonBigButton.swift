//
//  CommonBigButton.swift
//  IDEA Hospital
//
//  Created by yasser on 12/28/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class CommonBigButton: UIButton {

    override func awakeFromNib() {
        setBtn()
    }
    
    private func setBtn(){
        self.layer.cornerRadius = self.frame.height / 7
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(red: 0.0, green: 24.0/255.0, blue: 103.0/255.0, alpha: 1.0)
        self.titleLabel?.font = UIFont(name: "PTSans-Bold", size: 22)
        self.titleLabel?.textColor = .white
        self.titleLabel?.tintColor = .white
    }

}
