//
//  LoginViewModel.swift
//  IDEA Hospital
//
//  Created by Hossam on 12/24/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

//MARK:- LoginViewModel Protocol
protocol LoginViewModelProtocol : class {
    func login(email: String , password: String)
}

class LoginViewModel {
    
    //MARK:- Properties
    private weak var view: LoginVCProtocol!
    
    init(view: LoginVCProtocol){
        self.view = view
    }
}

//MARK:- Extension Private Methods
extension LoginViewModel {
    
    //MARK:- Private Methods
    private func dataValidation(name: String , email: String , mobile: String, password: String) ->Bool {
        
        if !ValidationManager.shared().isEmptyEmail(email: email){
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "The email field is required", title: "OK")
        }
        
        if !ValidationManager.shared().isValidEmail(email: email){
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Valid Email", title: "OK")
        }
        
        if !ValidationManager.shared().isEmptyPassword(password: password)
        {
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "The password field is required", title: "OK")
        }
        if !ValidationManager.shared().isValidPassword(password: password){
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Valid Password", title: "OK")
        }
        return true
    }
    
    private func signInWithEnteredData(email: String, password: String){
       self.view.showLoader()
        APIManager.login(email: email, password: password){ response in
            switch response{
            case .failure(let error):
                if error.localizedDescription == "The data couldn’t be read because it isn’t in the correct format." {
                    self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Something went wrong please try again", title: "OK")
                }
                print(error)
            case .success(let result):
                if result.code == 401 {
                    self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "\(result.message ?? "")", title: "OK")
                }else if result.code == 422 {
                    self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "\(result.message ?? "")", title: "OK")
                }else{
                    print(result.code)
                    UserDefaultsManager.shared().token = "Bearer \(result.data?.accessToken ?? "")"
                    UserDefaultsManager.shared().isLoggedIn = true
                    self.view.showCustomAlertSuccessfullyLoggedIn(type: .defaultAlert(title: "Successfully"), message: "You are LoggedIn", title: "OK")
                }
                
            }
        }
        self.view.hideLoader()
    }
}

//MARK:- LoginViewModelProtocol  Funcs
extension LoginViewModel : LoginViewModelProtocol {
    func login(email: String , password: String){
        if dataValidation(name: "", email: email, mobile: "", password: password){
            signInWithEnteredData(email: email, password: password)
    }
    }
}
