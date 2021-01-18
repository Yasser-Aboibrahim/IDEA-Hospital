//
//  SettingsVC.swift
//  IDEA Hospital
//
//  Created by yasser on 12/25/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

//MARK:- SettingsVC Protocol
protocol SettingsVCProtocol: class{
    func goToFavoriteVC()
    func goToMyAppointmentsVC()
    func goToAboutUsAndTerms(screenType: ScreenType)
    func goToContactUsVC(screenType: ScreenType)
    func goToLoginVC()
    func shareSettings()
    func showLoader()
    func hideLoader()
    func goToHomeVC()
    func showCusromAlert(type: AlertTypes, message: String, title: String)
    func showCustomAlertSuccessfullyLoggedOut(type: AlertTypes, message: String, title: String)
    func goToEditProfile()
}
class SettingsVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var settingsView: SettingsView!
    
    //MARK:- Properties
    var viewModel: SettingsViewModelProtocol!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.setup()
        setSettingsTableviewDelegate()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        setupNavigationItemsSettings(backAction: .popUpCurrent, color: .white)
        setupNavController(title: "Settings", settingColor: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor(white: 204.0 / 255.0, alpha: 1.0)
    }
    
    //MARK:- public Methods
    class func create() -> SettingsVC {
        let settingsVC: SettingsVC = UIViewController.create(storyboardName: Storyboards.settings, identifier: ViewControllers.settingsVC)
        settingsVC.viewModel = SettingsViewModel(view: settingsVC)
        return settingsVC
    }
}

//MARK:- Extension Private Methods
extension SettingsVC{
    // MARK:- Private Methods
    private func setSettingsTableviewDelegate(){
         settingsView.settingsTableView.delegate = self
         settingsView.settingsTableView.dataSource = self
    }
    
    private func setNavigation(){
        setupNavController(title: "Search Result", settingColor: true)
        setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: true)
    }
    
    private func setTabBar(){
        tabBarController?.tabBar.isHidden = false
        tabBarController?.selectedIndex = 1
    }
}

// MARK:- Extension MyAppointments TableView
extension SettingsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingsArrCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsView.settingsTableView.dequeueReusableCell(withIdentifier: Cells.settingsCell, for: indexPath) as! SettingsCell
        viewModel.cellCongiure(cell: cell, index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedCell(index: indexPath.row)
    }
}


//MARK:- Extension SettingsVC Protocol Func
extension SettingsVC: SettingsVCProtocol{
    func goToFavoriteVC() {
        let myFavoriteVC = MyFavoritesVC.create(comeFromSettings: true)
        navigationController?.pushViewController(myFavoriteVC, animated: true)
    }
    
    func goToMyAppointmentsVC() {
        let myAppointmentsVC = MyAppointmentsVC.create(comeFromSettings: true)
        navigationController?.pushViewController(myAppointmentsVC, animated: true)
    }
    
    func goToAboutUsAndTerms(screenType: ScreenType) {
        let aboutUsAndTermsVC = AboutUsAndTermsVC.create(screenType: screenType)
        navigationController?.pushViewController(aboutUsAndTermsVC, animated: true)
    }
    
    func goToContactUsVC(screenType: ScreenType) {
        let homeNurseVC = HomeNurseVC.create(screenType: screenType)
        navigationController?.pushViewController(homeNurseVC, animated: true)
    }
    
    func goToLoginVC() {
        let loginVC = LoginVC.create()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func shareSettings(){
            let textToShare = "Share To"
            if let myWebsite = URL(string: "whatsapp://send?text=Hello%20Friends%2C%20Sharing%20some%20data%20here...%20") {
                let objectsToShare = [textToShare, myWebsite] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = settingsView.settingsTableView
                self.present(activityVC, animated: true)
            }
    }
    func showLoader() {
        view.showLoading()
    }
    
    func hideLoader() {
        view.hideLoading()
    }
    
    func goToHomeVC() {
        let homeVC = HomeVC.create()
        navigationController?.pushViewController(homeVC, animated: true)
    }
    
    func goToEditProfile() {
        let editProfileVC = EditProfileVC.create()
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
    
    func showCustomAlertSuccessfullyLoggedOut(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title){
            self.dismiss(animated: true){
               self.viewModel.logOut()
            }
        }
    }
}
