//
//  EditProfileView.swift
//  IDEA Hospital
//
//  Created by yasser on 1/8/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class EditProfileView: UIView {

    //MARK:- Outlets
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var mobileTextField: CustomTextField!
    @IBOutlet weak var oldPasswordTextField: CustomTextField!
    @IBOutlet weak var newPasswordTextField: CustomTextField!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField!
    @IBOutlet weak var saveBtn: CommonButton!
    @IBOutlet weak var cancelBtn: CommonButton!
    
    //MARK:- Public Methods
    func setup(userData: UserDataEditProfile?){
        setUpTextfieldsLineAndImage(userData: userData)
        setButton()
    }
}

//MARK:- Extension Private Methods
extension EditProfileView{
    private func setUpTextfieldsLineAndImage(userData: UserDataEditProfile?){
        
        
        nameTextField.addLineView(leftImage: UIImage(named: "UserIcon")!, placeholder: userData?.name ?? "Your Name")
        emailTextField.addLineView(leftImage: UIImage(named: "EmailIcon")!, placeholder: userData?.email ?? "Your Email")
        mobileTextField.addLineView(leftImage:UIImage(named: "Image")! , placeholder: userData?.mobile ?? "Mobile Number")
        oldPasswordTextField.addLineView(leftImage: UIImage(named: "Password")!, placeholder: "Old Password")
        newPasswordTextField.addLineView(leftImage: UIImage(named: "Password")!, placeholder: "New Password")
        confirmPasswordTextField.addLineView(leftImage: UIImage(named: "Password")!, placeholder: "Confirm Password")
        nameTextField.text = userData?.name ?? "Your Name"
        emailTextField.text = userData?.email ?? "Your Email"
        mobileTextField.text = userData?.mobile ?? "Mobile Number"
    }
    
    private func setButton() {
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.tintColor = .white
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.tintColor = .white
        cancelBtn.backgroundColor = UIColor(red: 111.0 / 255.0, green: 4.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
    }
}
