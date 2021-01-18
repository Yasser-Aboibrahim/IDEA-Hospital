//
//  HomeNurseViewModel.swift
//  IDEA Hospital
//
//  Created by yasser on 12/24/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

protocol HomeNurseViewModelProtocol: class {
    func sendRequest(name: String, email: String , mobile: String, message: String)
    func getScreenType()-> ScreenType
    func getScreenTitle() -> String
}

class HomeNurseViewModel{
    
    // MARK:- Properties
    private weak var view: HomeNurseVCProtocol!
    private var screenType: ScreenType
    
    init(view: HomeNurseVCProtocol,screenType: ScreenType){
        self.view = view
        self.screenType = screenType
    }
    
    private func dataValidation(name: String , email: String , mobile: String, message: String) ->Bool {
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
        
        if message.isEmpty || message == "Enter Details" {
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Details", title: "OK")
            return false
        }
        return true
    }
}

// MARK:- Private Methods
extension HomeNurseViewModel{
    private func homeNursingRequest(name: String, email: String , mobile: String , message: String){
        let body = RequestBodyData(name: name, email: email, mobile: mobile
            , message: message)
        APIManager.homeNursing(body: body) { (response) in
            switch response {
            case .failure(let error):
                if error.localizedDescription == "The data couldn’t be read because it isn’t in the correct format." {
                }else{
                    print(error.localizedDescription)
                }
            case .success(let result ):
                self.view.showCustomAlertSuccessfullySent(type: .defaultAlert(title: "Request Sent"), message: "Thank You", title: "Ok")
                print(result)
                print("Done")
            }
        }
    }
    
    private func ContactUsRequest(name: String, email: String , mobile: String , message: String){
        let body = RequestBodyData(name: name, email: email, mobile: mobile
            , message: message)
        APIManager.contactUsRequest(body: body) { (response) in
            switch response {
            case .failure(let error):
                if error.localizedDescription == "The data couldn’t be read because it isn’t in the correct format." {
                }else{
                    print(error.localizedDescription)
                }
            case .success(let result ):
                self.view.showCustomAlertSuccessfullySent(type: .defaultAlert(title: "Successfully Sent"), message: "Thank You", title: "Ok")
                print(result)
                print("Done")
            }
        }
    }
}

// Mark:- Extension
extension HomeNurseViewModel: HomeNurseViewModelProtocol{
    func getScreenType() -> ScreenType {
        return self.screenType
    }
    
    func getScreenTitle() -> String {
        switch screenType{
        case .contactUs:
            return ScreensTitle.contactUs
        default:
            return ScreensTitle.homeNurse
        }
    }
    
    func sendRequest(name: String, email: String, mobile: String, message: String) {
        if dataValidation(name: name, email: email, mobile: mobile, message: message){
            switch screenType{
            case .contactUs:
                homeNursingRequest(name: name, email: email, mobile: mobile, message: message)
            case.homeNurse:
                ContactUsRequest(name: name, email: email, mobile: mobile, message: message)
            default:
                return
            }
        }
    }
}
