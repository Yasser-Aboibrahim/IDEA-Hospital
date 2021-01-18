//
//  MyAppointmentsVC.swift
//  IDEA Hospital
//
//  Created by yasser on 12/19/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

//MARK:- MyAppointmentsVC Protocol
protocol MyAppointmentsVCProtocol: class{
    func showLoader()
    func hideLoader()
    func reloadData()
    func noAppointmentsData()
    func tableFooterViewWithPagination()
    func showCusromAlert(type: AlertTypes, message: String, title: String)
    func setUPNavBarComeFromSettings(haveSettingBTN: Bool)
    func setUpTabBar()
    func setUPNavBarComeFromHome(haveSettingBTN: Bool)
}

class MyAppointmentsVC: UIViewController {

     //MARK:- Outlets
    @IBOutlet weak var myAppointmentsView: MyAppointmentsView!
    
    //MARK:- Properties
    private var viewModel: MyAppointmentsViewModelProtocol!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myAppointmentsView.setup()
        setMyAppoTableviewDelegate()
        setupBackground()
        viewModel.getAppointmentsDataWithPagination(pagination: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.setUpNavBar()
    }
    
    
    // MARK:- Public Methods
    class func create(comeFromSettings: Bool) -> MyAppointmentsVC {
        let myAppointmentsVC: MyAppointmentsVC = UIViewController.create(storyboardName: Storyboards.myAppointments, identifier: ViewControllers.myAppointmentsVC)
        myAppointmentsVC.viewModel = MyAppointmentsViewModel(view: myAppointmentsVC)
        myAppointmentsVC.viewModel.navigateFromWhere(comeFromSettings: comeFromSettings)
        return myAppointmentsVC
    }
    
    // MARK:- Private Methods
    private func setMyAppoTableviewDelegate(){
        myAppointmentsView.myAppointmentsTableView.delegate = self
        myAppointmentsView.myAppointmentsTableView.dataSource = self
    }

    private func setNavigation(haveSettingBTN: Bool, back: Back){
        setupNavController(title: "MY APPOINTMENTS", settingColor: false)
        setupNavigationItems(backAction: back, haveSettingBTN: haveSettingBTN)
    }
    
    private func setTabBar(){
        tabBarController?.tabBar.isHidden = false
        tabBarController?.selectedIndex = 2

    }

}

// MARK:- Extension MyAppointments TableView
extension MyAppointmentsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myAppointmentsView.myAppointmentsTableView.dequeueReusableCell(withIdentifier: Cells.myAppointmentsCell, for: indexPath) as! MyAppointmentsCell
        viewModel.configureMyAppointmentsCell(cell: cell, index: indexPath.row)
        cell.deleteBtn.tag = indexPath.row
        cell.delegate = self
        cell.locationBtn.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let indexPath = NSIndexPath(item: 1, section : 0)
            let secondCell = myAppointmentsView.myAppointmentsTableView.cellForRow(at: indexPath as IndexPath)
            secondCell?.frame.size.height = 0;
            self.view.layoutSubviews()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 217
    }
}

//MARK:- Extension UIScrollView Delegate (Paginationg)
extension MyAppointmentsVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (myAppointmentsView.myAppointmentsTableView.contentSize.height-100-scrollView.frame.size.height){
            // fetch more data
            guard !viewModel.paginationStatus() else{
                print("Already Fetching Data")
                return
            }
            myAppointmentsView.myAppointmentsTableView.tableFooterView = myAppointmentsView.createSpinnerFooter()
            // call api and send true to pagination
            viewModel.getAppointmentsDataWithPagination(pagination: true)
        }
    }
}


// MARK:- Extension MyAppointmentsVC Protocol func
extension MyAppointmentsVC: MyAppointmentsCellDelegate{
    func deleteBtnTapped(_ tag: Int) {
        viewModel.deleteAppointmentSuccessfully(index: tag)
    }
    
    func locationBtnTapped(_ tag: Int) {
        viewModel.getMapLocation(index: tag)
    }
}

// MARK:- Extension MyAppointmentsVC Protocol func
extension MyAppointmentsVC: MyAppointmentsVCProtocol{
    func noAppointmentsData() {
       myAppointmentsView.noDataLabel.text = "No Appointments"
    }
    
    func reloadData() {
        myAppointmentsView.myAppointmentsTableView.reloadData()
    }
    
    func showLoader() {
        self.view.showLoading()
    }
    
    func hideLoader() {
        self.view.hideLoading()
    }
    
    func tableFooterViewWithPagination(){
        DispatchQueue.main.async {
            self.myAppointmentsView.myAppointmentsTableView.tableFooterView = nil
        }
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
