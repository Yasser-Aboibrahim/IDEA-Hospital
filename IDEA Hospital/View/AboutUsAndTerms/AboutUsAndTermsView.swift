//
//  AboutUsAndTermsView.swift
//  IDEA Hospital
//
//  Created by yasser on 12/25/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class AboutUsAndTermsView: UIView {

    //MARK:- Outlets
    @IBOutlet weak var infoLabel: UILabel!
    
    //MARK:- Public Method
    func setup(content: String){
        infoLabel.text = content.htmlToString
        infoLabel.textAlignment = NSTextAlignment.left;
        infoLabel.textColor = UIColor.white
        infoLabel.font = UIFont(name: "PTSans-Regular" ,size: 14)
    }
}
