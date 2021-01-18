//
//  EditProfileViewModel.swift
//  IDEA Hospital
//
//  Created by yasser on 1/8/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import Foundation

//MARK:- EditProfileViewModel Protocol
protocol EditProfileViewModelProtocol: class{
    func editUserProfile(name: String,email: String, mobile: String, password: String, oldPassword: String, confirmationPassword: String )
    func getUserDataResponse()
}

class EditProfileViewModel{
    
    //MARK:- Properties
    private weak var view: EditProfileVCProtocol!
    
    //MARK:- Properties
    private var password: String? = nil
    private var oldPassword: String? = nil
    
    init(view: EditProfileVCProtocol){
        self.view = view
    }
}

//MARK:- Private Methods
extension EditProfileViewModel{
    
    private func dataValidation(name: String , email: String , mobile: String, newPassword: String, confirmationPassword: String , oldPassword: String) ->Bool {
        if !ValidationManager.shared().isEmptyName(name: name){
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Your Name", title: "OK")
            return false
        }
        
        if !ValidationManager.shared().isEmptyEmail(email: email){
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Email", title: "OK")
            return false
        }
        
        if !ValidationManager.shared().isValidEmail(email: email){
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Valid Email", title: "OK")
            return false
        }
        
        if !ValidationManager.shared().isEmptyMobile(mobile: mobile){
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Valid Mobile Number", title: "OK")
            return false
        }
        
        if !ValidationManager.shared().isValidPassword(password: oldPassword){
            self.oldPassword = nil
            self.password = nil
        }else{
            if !ValidationManager.shared().isValidPassword(password: newPassword){
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Valid New Password", title: "OK")
                return false
            }
            if newPassword != confirmationPassword {
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Not the Same Password", title: "OK")
                return false
            }
            
            self.oldPassword = oldPassword
            self.password = newPassword
        }
        
        if !ValidationManager.shared().isValidPassword(password: oldPassword) && ValidationManager.shared().isValidPassword(password: newPassword){
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Valid Old Password", title: "OK")
                return false
        }
        
        return true
    }
    
    private func editUserProfilePM(name: String,email: String, mobile: String) {
        let body = EditProfileBodyData(name: name, email: email, mobile: mobile, password: self.password, oldPassword: self.oldPassword)
        APIManager.editProfile(body: body){ (response) in
            switch response {
            case .failure (let error):
                print(error.localizedDescription)
                print(error)
            case .success(let result):
                self.view.showCusromAlertSuccessfullyProfileUpdated(type: .defaultAlert(title: "Successfully"), message: "Profile Updated", title: "Ok")
                print(result)
            }
        }
    }
    
    private func getUserDataResponsePM(){
            APIManager.getUserData{ (response) in
                switch response {
                case .failure (let error):
                    print(error.localizedDescription)
                    print(error)
                case .success(let result):
                    self.view.setUserData(userData: result.data)
                    print(result)
                }
            }
        
    }
}

//MARK:- Extension EditProfileViewModel Protocol funcs
extension EditProfileViewModel: EditProfileViewModelProtocol{
    func getUserDataResponse(){
        getUserDataResponsePM()
    }
    func editUserProfile(name: String,email: String, mobile: String, password: String, oldPassword: String, confirmationPassword: String ) {
        if dataValidation(name: name , email: email , mobile: mobile, newPassword: password, confirmationPassword: confirmationPassword , oldPassword: oldPassword){
        editUserProfilePM(name: name,email: email, mobile: mobile)
        }
    }
}
