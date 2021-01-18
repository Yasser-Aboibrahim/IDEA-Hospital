//
//  SearchResultView.swift
//  IDEA Hospital
//
//  Created by Hossam on 12/19/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class SearchResultView: UIView {

    //MARK:- Outlets
    @IBOutlet weak var SearchResultTableView: UITableView!
    @IBOutlet weak var filterTextField: UITextField!
    @IBOutlet weak var sortByLabel: UILabel!
    @IBOutlet weak var noDoctorsFoundLabel: UILabel!
    
    // MARK:- Properties
    let pickerView = UIPickerView()
    
    //MARK:- Public Methods
    func setup() {
        SearchResultTableView.backgroundColor = .clear
        setUpPickers()
        textFieldSetup()
        labelSetyp()
        setSearchResultTableView()
    }
    
    func createSpinnerFooter()-> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    //MARK:- Private Methods
    private func setupPicker(_ textField : UITextField){
        textField.inputView = pickerView
    }
    
    private func setUpPickers() {
        setupPicker(filterTextField)
    }
    
    private func textFieldSetup(){
        filterTextField.tintColor = UIColor.white
        filterTextField.backgroundColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        filterTextField.setLeftPaddingPoints(120)
        filterTextField.font = UIFont(name: "PTSans-Regular", size: 16)
        
    }
    
    private func labelSetyp(){
        sortByLabel.textAlignment = NSTextAlignment.center;
        sortByLabel.textColor = UIColor.white
        sortByLabel.font = UIFont(name: "PTSans-Regular" ,
                                 size: 16)
        sortByLabel.backgroundColor = .clear
        sortByLabel.text = "Sort By"
        
        noDoctorsFoundLabel.textAlignment = NSTextAlignment.center;
        noDoctorsFoundLabel.textColor = UIColor.white
        noDoctorsFoundLabel.font = UIFont(name: "PTSans-Bold" ,
                                  size: 40)
        noDoctorsFoundLabel.backgroundColor = .clear
        noDoctorsFoundLabel.text = ""
    }
    
    private func setSearchResultTableView(){
        SearchResultTableView.register(UINib(nibName: Cells.searchResultCell, bundle: nil), forCellReuseIdentifier: Cells.searchResultCell)
        SearchResultTableView.tableFooterView = UIView(frame: .zero)
        SearchResultTableView.rowHeight = UITableView.automaticDimension
    }
}
