//
//  SettingsCell.swift
//  IDEA Hospital
//
//  Created by yasser on 12/25/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

//MARK:- SettingsCell Protocol
protocol SettingsCellProtocol: class{
    func configure(image: String, title: String)
}

class SettingsCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var settingImageView: UIImageView!
    @IBOutlet weak var settingLabel: UILabel!
    
    // MARK:- Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

//MARK:- Extension Private Methods
extension SettingsCell{
    private func setCellView(){
        settingImageView.backgroundColor = .clear
        settingImageView.tintColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        settingImageView.contentMode = UIView.ContentMode.scaleToFill
        
        settingLabel.textAlignment = NSTextAlignment.left;
        settingLabel.textColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        settingLabel.font = UIFont(name: "PTSans-Regular" ,
                                  size: 20)
        
        self.backgroundColor = .clear
    }
}

//MARK:- Extension SettingsCell Protocol func
extension SettingsCell: SettingsCellProtocol{
    func configure(image: String, title: String){
        settingImageView.image = UIImage(named: image)
        settingLabel.text = title
    }
}
