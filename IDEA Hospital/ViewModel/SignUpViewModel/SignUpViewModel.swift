//
//  SignUpViewModel.swift
//  IDEA Hospital
//
//  Created by Hossam on 12/25/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

//MARK:- SignUpViewModelProtocol
protocol SignUpViewModelProtocol : class {
    func signUpUser( name: String, email: String, mobile: String, password: String, confirmationPassword: String)
}

class SignUpViewModel {
 
    //MARK:- Properties
    private weak var view: SignUpVCProtocol!
    
    init(view: SignUpVCProtocol){
        self.view = view
    }
}

//MARK:- Extension Private Methods
extension SignUpViewModel{
    private func dataValidation(name: String , email: String , mobile: String, password: String, confirmationPassword: String) ->Bool {
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
        
        if !ValidationManager.shared().isValidPassword(password: password){
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Valid Password", title: "OK")
            return false
        }
        
        if password != confirmationPassword {
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Not the Same Password", title: "OK")
            return false
        }
        return true
    }
    
    private func signUpWithEnteredData(name: String, email: String, mobile: String, password: String) {
        view.showLoader()
        let body = UserBodyData(name: name, email: email, mobile: mobile, password: password)
        APIManager.register(body: body){ (response) in
            switch response {
            case .failure (let error):
                print(error.localizedDescription)
                print(error)
            case .success(let result):
                if result.code == 422 {
                    self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "The email has already been taken", title: "OK")
                }
                else{
                    print(result)
                    print(result.data?.accessToken!)
                    UserDefaultsManager.shared().token = result.data?.accessToken
                    self.view.showCustomAlertSuccessfullySignedUp(type: .defaultAlert(title: "Successfully"), message: "Successfuly signed up", title: "OK")
                }
                }
            }
            self.view.hideLoader()
        }
    }

//MARK:- SignUpViewModelProtocol Funcs
extension SignUpViewModel : SignUpViewModelProtocol {
    func signUpUser(name: String, email: String, mobile: String, password: String, confirmationPassword: String) {
        if dataValidation(name: name, email: email, mobile: mobile, password: password, confirmationPassword: confirmationPassword) {
        signUpWithEnteredData( name: name, email: email, mobile: mobile, password: password)

    }
    }
}
