//
//  UIViewController+NavController.swift
//  IDEHospital
//
//  Created by bido elbasha on 12/12/2020.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import UIKit

extension UIViewController{
    enum Back: String {
        case dismissCurrent
        case popUpCurrent
    }
    
    func setupNavController(title: String, settingColor: Bool) {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.clipsToBounds = true
        if settingColor{
            navigationController?.navigationBar.barTintColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        } else {
            navigationController?.navigationBar.barTintColor = UIColor(white: 183.0 / 255.0, alpha: 1.0)
        }
        
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "PTSans-Bold", size: 20)!]
    }
    
    func setupNavigationItems(backAction: Back, haveSettingBTN: Bool) {
        let backItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: Selector(backAction.rawValue))
        backItem.tintColor = UIColor(red: 132.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
        let leftPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftPadding.width = 18
        navigationItem.leftBarButtonItems = [leftPadding, backItem]
        if haveSettingBTN{
            let settingsItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .done, target: self, action: #selector(showSettings))
            settingsItem.tintColor = UIColor(red: 132.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
            let rightPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            rightPadding.width = 18
            navigationItem.rightBarButtonItems = [rightPadding, settingsItem]
        }
        
    }
    
    @objc func popUpCurrent() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissCurrent() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func showSettings() {
        self.navigationController?.pushViewController(SettingsVC.create(), animated: true)
    }
    
    func setupNavigationItemsSettings(backAction: Back, color: UIColor) {
        let backItem = UIBarButtonItem(image: UIImage(named: "back3"), style: .done, target: self, action: Selector(backAction.rawValue))
        backItem.tintColor = color
        let leftPadding = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftPadding.width = 18
        navigationItem.leftBarButtonItems = [leftPadding, backItem]
        
    }
    
    func homeNurseAndContactUs(screenType: ScreenType){
        switch screenType{
        case .homeNurse:
            setupNavController(title: "HOME NURSE", settingColor: false)
            setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: true)
        case .contactUs:
            setupNavController(title: "CONTACT US", settingColor: false)
            setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: false)
        default:
            return
        }
    }
    
}
