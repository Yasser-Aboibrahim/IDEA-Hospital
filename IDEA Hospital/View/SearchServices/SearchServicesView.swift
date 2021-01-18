//
//  searchServicesView.swift
//  IDEA_Hospital_Team4
//
//  Created by Hossam on 12/8/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class SearchServicesView: UIView {
    
    // MARK:- Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var chooseSpecialistsTextField: UITextField!
    @IBOutlet weak var chooseCityTextField: UITextField!
    @IBOutlet weak var chooseRegionTextField: UITextField!
    @IBOutlet weak var chooseCompaniesTextField: UITextField!
    @IBOutlet weak var doctorNameTextField: UITextField!
    @IBOutlet weak var findDoctorButton: UIButton!
    
    // MARK:- Properties
    let pickerView = UIPickerView()
    
    // MARK:- Lifecycle methods
    func setup() {
        addBackground()
        setLabel()
        setupFindDoctor()
        setUpPickers()
        setUpTextFields()
    }
    
    func setupPicker(_ textField : UITextField){
        textField.inputView = pickerView
    }
}

//MARK:- Private Method
extension SearchServicesView {
    private func addBackground(imageName: String = "BackGroundpicture", contentMode: UIView.ContentMode = .scaleToFill) {
        // setup the UIImageView
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = contentMode
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)
        // adding NSLayoutConstraints
        let leadingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
    private func setLabel(){
        titleLabel.text = "IDEA EG HOSPITAL"
        titleLabel.textAlignment = NSTextAlignment.center;
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "PTSans-Bold" ,
                                 size: 35)
        secondTitleLabel.text = " IDEA EG HOSPITAL THE BEST CHOICE"
        secondTitleLabel.textAlignment = NSTextAlignment.center;
        secondTitleLabel.textColor = UIColor.white
        secondTitleLabel.font = UIFont(name: "PTSans-Regular" ,
                                       size: 20)
    }
    
    private func setupTextField(_ textField: UITextField, placeHolder: String,tag: Int, isSceure: Bool) {
        textField.backgroundColor = UIColor.init(white: 237.0 / 255.0, alpha: 1.0)
        textField.textColor = UIColor.black
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "PTSans-Regular", size: 20)!])
        textField.font = UIFont(name: "PTSans-Regular", size: 20)
        

        
        textField.font = UIFont(name: textField.font!.fontName,
                                size: 20)
        textField.textAlignment = NSTextAlignment.left;
        textField.isSecureTextEntry = isSceure
        textField.layer.cornerRadius = 10
        textField.tag = tag
        textField.setLeftPaddingPoints(10)
    }
    
    private func setupFindDoctor() {
        findDoctorButton.titleLabel?.font = UIFont(name: "PTSans-Regular", size: 22)
        findDoctorButton.setTitle("Find a doctor", for: .normal)
        findDoctorButton.setTitleColor(.white , for: .normal)
    }
    
    func setUpPickers() {
        setupPicker(chooseSpecialistsTextField)
        setupPicker(chooseCityTextField)
        setupPicker(chooseCompaniesTextField)
        setupPicker(chooseRegionTextField)
    }
    
    func setUpTextFields() {
        setupTextField(chooseSpecialistsTextField, placeHolder: "Choose Specialists",tag: 1, isSceure: false)
        setupTextField(chooseCityTextField, placeHolder: "Choose city" ,tag: 2 , isSceure: false)
        setupTextField(chooseRegionTextField, placeHolder: "Choose Region" , tag: 3, isSceure: false)
        setupTextField(chooseCompaniesTextField, placeHolder: "Choose Companies", tag: 4, isSceure: false)
        setupTextField(doctorNameTextField, placeHolder: "Doctor name" , tag: 5 ,  isSceure: false)
    }
}
