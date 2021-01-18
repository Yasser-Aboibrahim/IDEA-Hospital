//
//  VoucherView.swift
//  IDEA Hospital
//
//  Created by Hossam Yasser on 12/31/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit


class VoucherView: UIView {
    
    //Mark:- Outlets
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstSwitch: UISwitch!
    @IBOutlet weak var secondSwitch: UISwitch!
    @IBOutlet weak var enterCodeTextField: UITextField!
    @IBOutlet weak var enterNameTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    //MARK:- Setup
    func setup(){
        setuptextField(enterCodeTextField, placeHolder: "Enter Code")
        setuptextField(enterNameTextField, placeHolder: "Enter Name")
        setUpButton()
        setLabel()
        switchSetup()
    }
}

//MARK:- Public Methods
extension VoucherView{
    func firstSwitchIsOn()->Bool{
        enterCodeTextField.isEnabled = true
        enterCodeTextField.isHidden = false
        firstSwitch.onTintColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        firstSwitch.tintColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        firstSwitch.thumbTintColor = .white
        return true
    }
    
    func firstSwitchNotIsOn()->Bool{
        enterCodeTextField.isEnabled = false
        enterCodeTextField.isHidden = true
        enterCodeTextField.borderStyle = .none
        firstSwitch.onTintColor =  UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        firstSwitch.tintColor =  UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        firstSwitch.thumbTintColor = UIColor.white
        return false
    }
    
    func secondSwitchIsOn()->Bool{
        enterNameTextField.isEnabled = true
        enterNameTextField.isHidden = false
        enterNameTextField.borderStyle = .none
        secondSwitch.onTintColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        secondSwitch.tintColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        secondSwitch.thumbTintColor = .white
        return true
    }
    
    func secondSwitchNotIsOn()->Bool{
        enterNameTextField.isEnabled = false
        enterNameTextField.isHidden = true
        enterNameTextField.borderStyle = .none
        secondSwitch.onTintColor =  UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        secondSwitch.tintColor =  UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        secondSwitch.thumbTintColor = .white
        return false
    }
}

//MARK:- Private Method
extension VoucherView {
    
    func setuptextField(_ textField: UITextField, placeHolder: String) {
        enterCodeTextField.layer.borderColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0).cgColor
        enterCodeTextField.layer.borderWidth = 1
        enterCodeTextField.backgroundColor = .white
        enterNameTextField.layer.borderColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0).cgColor
        enterNameTextField.layer.borderWidth = 1
        enterNameTextField.backgroundColor = .white
        textField.textColor = UIColor.black
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "PTSans-Regular", size: 15)!])
        textField.font = UIFont(name: "PTSans-Regular", size: 15)
   
        textField.font = UIFont(name: textField.font!.fontName,
                                size: 15)
        textField.textAlignment = NSTextAlignment.left;
        textField.setLeftPaddingPoints(10)
    }
    
    private func setUpButton(){
        continueButton.backgroundColor = UIColor.init(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        continueButton.layer.cornerRadius = 12
        continueButton.titleLabel?.font = UIFont(name: "PTSans-Regular", size: 15)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(.white , for: .normal)
}
    
    private func setLabel(){
        firstLabel.text = "Do you have a Voucher Code?"
        firstLabel.textAlignment = NSTextAlignment.center;
        firstLabel.textColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        firstLabel.font = UIFont(name: "PTSans-Bold" ,
                                 size: 15)
        
        secondLabel.text = "Are you Booking for another person?"
        secondLabel.textAlignment = NSTextAlignment.center;
        secondLabel.textColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        secondLabel.font = UIFont(name: "PTSans-Bold" ,
                                 size: 15)
    }
    
    private func switchSetup(){
        firstSwitch.onTintColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        firstSwitch.tintColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        firstSwitch.thumbTintColor = .white
        
        secondSwitch.onTintColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        secondSwitch.tintColor = UIColor(red: 0.0, green: 24.0 / 255.0, blue: 103.0 / 255.0, alpha: 1.0)
        secondSwitch.thumbTintColor = .white
    }
}
