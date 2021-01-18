//
//  MyFavoritesVC.swift
//  IDEA Hospital
//
//  Created by yasser on 12/18/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

protocol MyFavoritesVCProtocol: class{
    func showLoader()
    func hideLoader()
    func reloadData()
    func noFavoriteData()
    func tableFooterViewWithPagination()
    func goToDoctorProfileVC(doctorId: Int)
    func showCusromAlert(type: AlertTypes, message: String, title: String)
    func setUPNavBarComeFromHome(haveSettingBTN: Bool)
    func setUpTabBar()
    func setUPNavBarComeFromSettings(haveSettingBTN: Bool)
}

class MyFavoritesVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var myFavoritesview: MyFavoritesView!
    
    //MARK:- Properties
    private var viewModel: MyFavoritesViewModelProtocol!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setMyFavTableviewDelegate()
        setupBackground()
        viewModel.getFavoritesDataPagination(pagination: true)
        myFavoritesview.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.setUpNavBar()
    }
    
    // MARK:- Public Methods
    class func create(comeFromSettings: Bool) -> MyFavoritesVC {
        let myFavoritesVC: MyFavoritesVC = UIViewController.create(storyboardName: Storyboards.myFavorites, identifier: ViewControllers.myFavoritesVC)
        myFavoritesVC.viewModel = MyFavoritesViewModel(view: myFavoritesVC)
        myFavoritesVC.viewModel.navigateFromWhere(comeFromSettings: comeFromSettings)
        return myFavoritesVC
    }
    
    // MARK:- Private Methods
    private func setMyFavTableviewDelegate(){
        myFavoritesview.myFavoritesTableView.delegate = self
        myFavoritesview.myFavoritesTableView.dataSource = self
    }
    
    private func setNavigation(haveSettingBTN: Bool, back: Back){
        setupNavController(title: "MY FAVORITES" , settingColor: false)
        setupNavigationItems(backAction: back, haveSettingBTN: haveSettingBTN)
    }
    
    private func setTabBar(){
        tabBarController?.tabBar.isHidden = false
        tabBarController?.selectedIndex = 1
    }
}

// MARK:- Extension TableView
extension MyFavoritesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myFavoritesview.myFavoritesTableView.dequeueReusableCell(withIdentifier: Cells.myFavoritesCell, for: indexPath) as! MyFavoritesCell
        viewModel.configureMyFavoritesCell(cell: cell, index: indexPath.row)
        cell.deleteBtn.tag = indexPath.row
        cell.delegate = self
        cell.viewProfileBtn.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 265
    }
}

//MARK:- Extension UIScrollView Delegate (Paginationg)
extension MyFavoritesVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (myFavoritesview.myFavoritesTableView.contentSize.height-100-scrollView.frame.size.height){
            // fetch more data
            guard !viewModel.paginationStatus() else{
                print("Already Fetching Data")
                return
            }
            self.myFavoritesview.myFavoritesTableView.tableFooterView = myFavoritesview.createSpinnerFooter()
            // call api and send true to pagination
            viewModel.getFavoritesDataPagination(pagination: true)
        }
    }
}

// MARK:- Extension MyFavoritesVC Protocol func
extension MyFavoritesVC: MyFavoritesCelllDelegate{
    func deleteBtnTapped(_ tag: Int) {
        viewModel.addAndRemoveFavorites(index: tag)
    }
    
    func viewPrfileBtnTapped(_ tag: Int) {
        viewModel.goToViewProfile(index: tag)
    }
}

// MARK:- MyFavoritesVC Protocol funcs
extension MyFavoritesVC: MyFavoritesVCProtocol{
    func noFavoriteData() {
            myFavoritesview.noFavoritesData.text = "No Favorites"
    }
    
    func reloadData() {
        myFavoritesview.myFavoritesTableView.reloadData()
    }
    
    func showLoader() {
        self.view.showLoading()
    }
    
    func hideLoader() {
        self.view.hideLoading()
    }
    
    func tableFooterViewWithPagination(){
        DispatchQueue.main.async {
            self.myFavoritesview.myFavoritesTableView.tableFooterView = nil
        }
    }
    
    func goToDoctorProfileVC(doctorId: Int) {
        let doctorProfileVC = DoctorProfileVC.create(doctorId: doctorId)
        navigationController?.pushViewController(doctorProfileVC, animated: true)
    }
    
    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
    
    func setUPNavBarComeFromHome(haveSettingBTN: Bool) {
        setNavigation(haveSettingBTN: haveSettingBTN, back: .dismissCurrent)
    }
    
    func setUpTabBar() {
        setTabBar()
    }
    
    func setUPNavBarComeFromSettings(haveSettingBTN: Bool) {
        setNavigation(haveSettingBTN: haveSettingBTN, back: .popUpCurrent)
    }
    
}

