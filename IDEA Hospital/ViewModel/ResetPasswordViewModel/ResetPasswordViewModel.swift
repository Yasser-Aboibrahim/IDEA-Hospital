//
//  ResetPasswordViewModel.swift
//  IDEA Hospital
//
//  Created by Hossam on 12/24/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

//MARK:- ResetPasswordViewModel Protocol
protocol ResetPasswordViewModelProtocol : class {
    func resetForgottenPassword(email: String)
}

class ResetPasswordViewModel {

    //MARK:- Properties
    private weak var view: ResetPasswordVCProtocol!
    
    init(view: ResetPasswordVCProtocol){
        self.view = view
    }
}

//MARK:- Extension Private Methods
extension ResetPasswordViewModel {
    
    private func ResetPassword(email: String) {
        view.showLoader()
        APIManager.forgotPassword(email: email) { [weak self] (response) in
            switch response {
            case .failure(let error):
                print(error)
            case .success(let result):
                if result.code == 422 {
                    self!.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Valid Email", title: "OK")
                }else{
                print(result)
                    self!.view.showCustomAlertSuccessfullyPasswordReset(type: .defaultAlert(title: "Successfully"), message: "The password has changed", title: "OK")
                }
            }
              self!.view.hideLoader()
            }
        }
    }

//MARK:- Extension ResetPasswordViewModel Protocol funcs
extension ResetPasswordViewModel : ResetPasswordViewModelProtocol {
    func resetForgottenPassword(email: String) {
                ResetPassword(email: email)
    }
}

