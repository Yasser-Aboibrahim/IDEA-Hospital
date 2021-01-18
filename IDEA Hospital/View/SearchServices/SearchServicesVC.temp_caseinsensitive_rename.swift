//
//  SearchServicesVC.swift
//  IDEA_Hospital_Team4
//
//  Created by Hossam on 12/8/20.
//  Copyright © 2020 IOS. All rights reserved.

import UIKit
import IQKeyboardManager

protocol SearchServicesVCProtocol: class{
    func showAlert()
    func showLoader()
    func hideLoader()
    func showItems()
    func addSelectedItem(_ viewWithTag: Int, _ item: String)
    func clearTextField(with tag: Int)
    func doneButtonEnabled(_ enabled: Bool , for tag: Int)
}

class SearchServicesVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var searchServicesView: searchServicesView!
    
    // MARK:- Properties
    var viewModel : SearchServicesViewModelProtocol!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        searchServicesView.setup()
        viewModel.prepareCategories(with: 1)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
        setStatusBar()
    }
    
    // MARK:- Public Methods
    class func create(categoryID: Int) -> SearchServicesVC {
        let SearchServicesVC: SearchServicesVC = UIViewController.create(storyboardName: Storyboards.main, identifier: "searchServicesVC")
        SearchServicesVC.viewModel = SearchSearvicesViewModel(view: SearchServicesVC)
        SearchServicesVC.viewModel.prepareCategories(with: categoryID)
        return SearchServicesVC
    }
    
    @objc private func doneTapped(_ sender: UIBarButtonItem) {
        viewModel.selectedItems(tag: sender.tag,row: searchServicesView.pickerView.selectedRow(inComponent: 0))
    }
    
    func setStatusBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.init(white: 204.0/255.0, alpha: 1.0)
        
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
    func showAlert() {
        ShowAlertsManager.showAlertWithCancel(alertTitle: "Error", message: "Loading Error", actionTitle: "Dismiss")
    }
    
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
}

// MARK:- TextField Delegate
extension SearchServicesVC : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        viewModel.pickerItem(with: textField.tag)
        textField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneTapped(_:)))
        return true
    }
}
