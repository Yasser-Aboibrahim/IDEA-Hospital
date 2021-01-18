//
//  SettingsView.swift
//  IDEA Hospital
//
//  Created by yasser on 12/25/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class SettingsView: UIView {

    //MARK:- Outlets
    @IBOutlet weak var settingsTableView: UITableView!
    
    //MARK:- Public Methods
    func setup() {
        self.backgroundColor =  UIColor(white: 219.0 / 255.0, alpha: 1.0)
        settingsTableView.backgroundColor = UIColor(white: 219.0 / 255.0, alpha: 1.0)
        setSettingsTableview()
    }

    //MARK:- Private Methods
    private func setSettingsTableview(){
        settingsTableView.tableFooterView = UIView(frame: .zero)
        settingsTableView.estimatedRowHeight = 44
        settingsTableView.alwaysBounceVertical = false;
        settingsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        settingsTableView.register(UINib(nibName: Cells.settingsCell, bundle: nil), forCellReuseIdentifier: Cells.settingsCell)
    }
}
