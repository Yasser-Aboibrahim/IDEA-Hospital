//
//  SignUpAndLoginPopUpViewModel.swift
//  IDEA Hospital
//
//  Created by Hossam Yasser on 1/8/21.
//  Copyright © 2021 Yasser Aboibrahim. All rights reserved.
//

import Foundation

//MARK:- SignUpAndLoginPopUpViewModelProtocol Protocol
protocol SignUpAndLoginPopUpViewModelProtocol : class {
    func signUpUser(name: String, email: String, mobile: String, password: String, voucher: String, patientName: String, bookForAnother: Bool)
    func login(email: String , password: String, voucher: String, patientName: String, bookForAnother: Bool)
    func getNameState(nameEntered: Bool)
    func getVoucherState(voucherEntered: Bool)
    func setDefaultData()
}

class SignUpAndLoginPopUpViewModel{
    //MARK:- Properties
    private weak var view: SignUpAndLoginPopUpProtocol!
    private var patientName: String!
    private var bookForAnother: Bool!
    private var doctorId: Int
    private var appointmentTimeStamp: String
    private var voucherState: Bool = false
    private var nameState: Bool = false
    private var voucherValue: String? = nil
    
    init(view: SignUpAndLoginPopUpProtocol,doctorId: Int, appointmentTimeStamp: String){
        self.view = view
        self.doctorId = doctorId
        self.appointmentTimeStamp = appointmentTimeStamp
    }
}

//MARK:- Extension Private Methods
extension SignUpAndLoginPopUpViewModel{
    private func dataValidation(name: String , email: String , mobile: String, password: String, voucher: String, patientName: String) ->Bool {
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
        
        if voucherState{
            if !ValidationManager.shared().isEmptyComment(comment: voucher) {
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Voucher", title: "ok")
                return false
            }else{
                voucherValue = voucher
            }
        }
        
        if nameState{
            if !ValidationManager.shared().isEmptyComment(comment: patientName) {
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Patient Name is required", title: "ok")
                return false
            }
        }
        return true
    
}
     private func dataValidator( email: String , password: String, voucher: String, patientName: String) ->Bool {
        
        if !ValidationManager.shared().isEmptyEmail(email: email){
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Email", title: "OK")
            return false
        }
        
        if !ValidationManager.shared().isValidEmail(email: email){
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Valid Email", title: "OK")
            return false
        }
        
        if !ValidationManager.shared().isValidPassword(password: password){
            self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Valid Password", title: "OK")
            return false
        }
        
        if voucherState{
            if !ValidationManager.shared().isEmptyComment(comment: voucher) {
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Please Enter Voucher", title: "ok")
                return false
            }else{
                voucherValue = voucher
            }
        }
        if nameState{
            if !ValidationManager.shared().isEmptyComment(comment: patientName) {
                self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Patient Name is required", title: "ok")
                return false
            }
        }
        return true
    }
    
    private func signUpWithEnteredData(name: String, email: String, mobile: String, password: String, voucher: String, patientName: String, bookForAnother: Bool) {
        view.showLoader()
        let body = NewUserBodyData(name: name, email: email, mobile: mobile, password: password, doctorId: self.doctorId, appointment: self.appointmentTimeStamp, voucher: self.voucherValue, patientName: patientName, bookForAnother: bookForAnother)
        APIManager.registerAndBookForNewUsers(body: body){ (response) in
            switch response {
            case .failure (let error):
                print(error.localizedDescription)
                print(error)
            case .success(let result):
                
                if result.code == 401 {
                        self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "Sorry This appointment has been booked.", title: "OK")
                }else if result.code == 422 && result.errors?.email ?? [""] == ["The email has already been taken."]{
                    self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "The email has already been taken.", title: "Ok")
                }else if result.code == 422 && result.errors?.voucher ?? [""]  == ["The selected voucher is invalid."] {
                    self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "The selected voucher is invalid", title: "Ok")
                } else{
                    print(result)
                    print(result.data?.accessToken!)
                    UserDefaultsManager.shared().token = "Bearer \(result.data?.accessToken ?? "")"
                    UserDefaultsManager.shared().isLoggedIn = true
                    self.view.showCustomAlertSuccessfullyRequest(type: .successButton, message: "Successfully Booked", title: "OK")
                }
            }
        }
        self.view.hideLoader()
    }
    
    private func signInWithEnteredData(email: String, password: String, voucher: String, patientName: String, bookForAnother: Bool){
        self.view.showLoader()
        let body = UserloginBodyData(email: email, password: password, doctorId: self.doctorId, appointment: self.appointmentTimeStamp, voucher: self.voucherValue, patientName: patientName, bookForAnother: bookForAnother)
        APIManager.loginAndBook(body: body){ response in
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
                    self.view.showCusromAlert(type: .defaultAlert(title: "Sorry"), message: "The selected voucher is invalid", title: "OK")
                }else{
                    print(result.code)
                    UserDefaultsManager.shared().token = "Bearer \(result.data?.accessToken ?? "")"
                    UserDefaultsManager.shared().isLoggedIn = true
                    self.view.showCustomAlertSuccessfullyRequest(type: .successButton, message: "Successfully Booked", title: "OK")
                }
                
            }
        }
        self.view.hideLoader()
    }
    
}

//MARK:- Extension DoctorProfileViewModel Protocol funcs
extension SignUpAndLoginPopUpViewModel: SignUpAndLoginPopUpViewModelProtocol{
    func getNameState(nameEntered: Bool) {
        nameState = nameEntered
        patientName = ""
    }
    
    func getVoucherState(voucherEntered: Bool) {
        voucherState = voucherEntered
        voucherValue = nil
    }
    
    func signUpUser(name: String, email: String, mobile: String, password: String, voucher: String, patientName:String , bookForAnother: Bool ) {
        if dataValidation(name: name, email: email, mobile: mobile, password: password, voucher: voucher, patientName: patientName) {
            signUpWithEnteredData( name: name, email: email, mobile: mobile, password: password, voucher: voucher, patientName: patientName, bookForAnother: bookForAnother)
        }
    }
    
    func login(email: String , password: String, voucher: String, patientName: String, bookForAnother: Bool){
        if dataValidator(email: email, password: password, voucher: voucher, patientName: patientName){
            signInWithEnteredData(email: email, password: password, voucher: voucher, patientName: patientName, bookForAnother: bookForAnother)
        }
    }
    
    func setDefaultData(){
        self.voucherValue = nil
        self.voucherState = false
        self.nameState = false
    }
    }





