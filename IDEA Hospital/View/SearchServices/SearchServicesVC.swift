//
//  SearchServicesVC.swift
//  IDEA_Hospital_Team4
//
//  Created by Hossam on 12/8/20.
//  Copyright © 2020 IOS. All rights reserved.

import UIKit
import IQKeyboardManager

protocol SearchServicesVCProtocol: class{
    func showLoader()
    func hideLoader()
    func showItems()
    func addSelectedItem(_ viewWithTag: Int, _ item: String)
    func clearTextField(with tag: Int)
    func doneButtonEnabled(_ enabled: Bool , for tag: Int)
    func goToSearchResultVC(categoryId: Int, specialtyId:Int?, cityId:Int?, regionId:Int?, companyId: Int?, name: String?)
    func showCusromAlert(type: AlertTypes, message: String, title: String)
}

class SearchServicesVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var searchServicesView: SearchServicesView!
    
    // MARK:- Properties
    private var viewModel : SearchServicesViewModelProtocol!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        searchServicesView.setup()
        viewModel.prepareCategories()
        setNavigation()
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
        setStatusBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTabBar()
    }
    
    // MARK:- Public Methods
    class func create(categoryID: Int) -> SearchServicesVC {
        let SearchServicesVC: SearchServicesVC = UIViewController.create(storyboardName: Storyboards.main, identifier: "searchServicesVC")
        SearchServicesVC.viewModel = SearchSearvicesViewModel(view: SearchServicesVC, categoryId: categoryID)
        return SearchServicesVC
    }
    
    @objc private func doneTapped(_ sender: UIBarButtonItem) {
        viewModel.selectedItems(tag: sender.tag,row: searchServicesView.pickerView.selectedRow(inComponent: 0))
    }
    
    
    func goToSearchResultVC(categoryId: Int, specialtyId: Int?, cityId: Int?, regionId: Int?, companyId: Int?, name: String?){
        let gotoSearchResultVC = SearchResultVC.create(ctegoryId: categoryId, specialtyId: specialtyId, cityId: cityId, regionId: regionId, companyId: companyId, name: name)
        navigationController?.pushViewController(gotoSearchResultVC, animated: true)
    }
    
    //MARK:- actions
    @IBAction func findDoctorButtonTapped(_ sender: UIButton) {
        viewModel.goToSearchResultVC(doctorName: searchServicesView.doctorNameTextField.text ?? "")
    }
}

//MARK:- Private Method

extension SearchServicesVC{
    private func setupPicker() {
        self.searchServicesView.chooseCityTextField.delegate = self
        self.searchServicesView.chooseSpecialistsTextField.delegate = self
        self.searchServicesView.chooseRegionTextField.delegate = self
        self.searchServicesView.chooseCompaniesTextField.delegate = self
        self.searchServicesView.pickerView.delegate = self
        self.searchServicesView.pickerView.dataSource = self
    }
    
    private func setNavigation(){
        setupNavController(title: "SEARCH SERVICES", settingColor: false)
        setupNavigationItems(backAction: .dismissCurrent, haveSettingBTN: true)
    }
    
    private func setTabBar(){
        tabBarController?.tabBar.isHidden = false
        tabBarController?.selectedIndex = 0
    }
}

extension SearchServicesVC : UIPickerViewDataSource , UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.itemsCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.getItems(row: row)
    }
}

// Mark:- Extension
extension SearchServicesVC: SearchServicesVCProtocol{
    
    func showItems() {
        self.searchServicesView.pickerView.reloadAllComponents()
    }
    
    func addSelectedItem(_ viewWithTag: Int, _ item: String) {
        let textField = self.searchServicesView.viewWithTag(viewWithTag) as! UITextField
        textField.text = item
    }
    
    func clearTextField(with tag: Int) {
        let textField = self.searchServicesView.viewWithTag(tag) as! UITextField
        textField.text = ""
    }
    
    func doneButtonEnabled(_ enabled: Bool, for tag: Int) {
        let textField = self.searchServicesView.viewWithTag(tag) as! UITextField
        textField.keyboardToolbar.doneBarButton.isEnabled = enabled
    }
    
    func showLoader() {
        self.view.showLoading()
    }
    
    func hideLoader() {
        self.view.hideLoading()
    }
    
    func showCusromAlert(type: AlertTypes, message: String, title: String) {
        openCustomAlert(type: type, message: message, title: title)
    }
}

// MARK:- TextField Delegate
extension SearchServicesVC : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        viewModel.pickerItem(with: textField.tag)
        textField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneTapped(_:)))
        return true
    }
}
