//
//  SearchResultVC.swift
//  IDEA Hospital
//
//  Created by Hossam on 12/19/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

//MARK:- SearchResultVC Protocol
protocol SearchResultVCProtocol: class{
    func showLoader()
    func hideLoader()
    func reloadData()
    func addSelectedItem(_ item: String)
    func tableFooterViewWithPagination()
    func noDoctorData()
    func goToDoctorProfileVC(doctorId: Int)
    func showCusromAlert(type: AlertTypes, message: String, title: String)
}

class SearchResultVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet var searchResultView: SearchResultView!
    
    //MARK:- Properties
    private var viewModel :SearchResultViewModelProtocol!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchResultTableViewDelegate()
        searchResultView.setup()
        setupBackground()
        setupPicker()
        viewModel.getSearchResultDataWithFiletsWithPaginationPro(pagination: true)
        setNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTabBar()
    }
    
    // MARK:- Public Methods
    class func create(ctegoryId: Int, specialtyId:Int?, cityId:Int?, regionId:Int?, companyId: Int?, name: String?) -> SearchResultVC {
        let searchResultVC: SearchResultVC = UIViewController.create(storyboardName: Storyboards.searchResult, identifier: ViewControllers.searchResultVC)
        searchResultVC.viewModel = SearchResultViewModel(view: searchResultVC, categoryId: ctegoryId, specialtyId: specialtyId, cityId: cityId, regionId: regionId, companyId: companyId, doctorName: name)
        return searchResultVC
    }
}

//MARK:-Extension Private Methods
extension SearchResultVC{
    private func setupPicker() {
        self.searchResultView.filterTextField.delegate = self
        self.searchResultView.pickerView.delegate = self
        self.searchResultView.pickerView.dataSource = self
    }
    
    private func setSearchResultTableViewDelegate(){
        searchResultView.SearchResultTableView.delegate = self
        searchResultView.SearchResultTableView.dataSource = self
    }
    
    private func setNavigation(){
        setupNavController(title: "Search Result", settingColor: false)
        setupNavigationItems(backAction: .popUpCurrent, haveSettingBTN: true)
    }
    
    private func setTabBar(){
        tabBarController?.tabBar.isHidden = false
        tabBarController?.selectedIndex = 0
    }
}

//MARK:- Extension TableView Delegate and DataSource
extension SearchResultVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.doctorCellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultView.SearchResultTableView.dequeueReusableCell(withIdentifier: Cells.searchResultCell, for: indexPath) as! TableViewCell
        viewModel.tableViewCellConfiguration(cell: cell, index: indexPath.row)
        cell.favouriteButton.tag = indexPath.row
        
        cell.delegate = self
        cell.bookNowButton.tag = indexPath.row
        let sep = CALayer()
        sep.backgroundColor = tableView.separatorColor?.cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 264
    }
}

//MARK:- Extension tableView cell deleagate
extension SearchResultVC: TableViewCellDelegate{
    func bookNowButtonTapped(index: Int) {
        viewModel.bookWithDoctorId(index: index)
    }
    
    func favoriteButtonTapped(index: Int) {
        viewModel.addFavoritesuccessfully(index: index)
    }
}

// MARK:- TextField Delegate
extension SearchResultVC : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //viewModel.pickerItem(with: textField.tag)
        textField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneTapped(_:)))
        return true
    }
    
    @objc private func doneTapped(_ sender: UIBarButtonItem) {
        viewModel.selectedItems(row: searchResultView.pickerView.selectedRow(inComponent: 0))
    }
}

//MARK:- Extension UIPicker Delegate and DataSource
extension SearchResultVC : UIPickerViewDelegate , UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.doctorFilterPicker().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.doctorFilterPicker()[row]
    }
}

//MARK:- Extension UIScrollView Delegate (Paginationg)
extension SearchResultVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (searchResultView.SearchResultTableView.contentSize.height-100-scrollView.frame.size.height){
            // fetch more data
            guard !viewModel.paginationStatus() else{
                print("Already Fetching Data")
                return
            }
            self.searchResultView.SearchResultTableView.tableFooterView = searchResultView.createSpinnerFooter()
            // call api and send true to pagination
            viewModel.getSearchResultDataWithFiletsWithPaginationPro(pagination: true)
        }
    }
}

//MARK:- Extension SearchResultVCProtocol Funcs
extension SearchResultVC: SearchResultVCProtocol{
    func goToDoctorProfileVC(doctorId: Int) {
        let doctorProfileVC = DoctorProfileVC.create(doctorId: doctorId)
        navigationController?.pushViewController(doctorProfileVC, animated: true)
    }
    
    func addSelectedItem(_ item: String) {
        searchResultView.filterTextField.text = item
    }
    
    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
    
    func reloadData() {
        searchResultView.SearchResultTableView.reloadData()
    }
    
    func showLoader() {
        self.view.showLoading()
    }
    
    func hideLoader() {
        self.view.hideLoading()
    }
    
    func tableFooterViewWithPagination(){
        DispatchQueue.main.async {
            self.searchResultView.SearchResultTableView.tableFooterView = nil
        }
    }
    
    func noDoctorData() {
        searchResultView.noDoctorsFoundLabel.text = "No Doctors"
    }
}
